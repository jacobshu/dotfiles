import os
import sys
import hashlib
import fileinput
import subprocess
from pyngrok import ngrok
from dotenv import main
from git import Repo, exc

main.load_dotenv()

# pull changes from remote
app_repo = Repo(os.getenv('GIT_APP'))
api_repo = Repo(os.getenv('GIT_API'))
# api_repo = Repo('/Users/jacobshu/dev/synthwave')  # failure case
try:
    api_repo.remotes.origin.pull()
    app_repo.remotes.origin.pull()
except exc.CommandError as e:
    sys.exit('Error during git pull:' + e.stderr)

# Check for a change in the stored procedures and prompt
# Since there's no ARM support for sqlcmd the procedure query has to be run on a GUI client
with open(os.getenv('SQL_PATH'), 'rb') as f:
    new_hash = hashlib.md5()
    for chunk in iter(lambda: f.read(4096), b''):
        new_hash.update(chunk)
    if os.getenv('SQL_HASH') != new_hash.hexdigest():
        sys.exit('SQL hash difference.\nNew hash: ' + new_hash.hexdigest())

# Open Docker and start the daemon
# Run the swm container
docker = subprocess.run(['open', '/Applications/Docker.app'], stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        universal_newlines=True)

# Open an HTTPS tunnel on port 5003 with ngrok
http_tunnel = ngrok.connect('5003', bind_tls=True)

# Get the URL from ngrok without the protocol
public_url = http_tunnel.public_url[8:]

# Write the public ngrok URL to the pkg-mgmt .env file
pkg_env = os.getenv('PKG_ENV')
for line in fileinput.input(pkg_env, inplace=True):
    if 'SERVER' in line:
        sys.stdout.write('SERVER=' + public_url + '\n')
    else:
        sys.stdout.write(line)

print('localhost proxied at ' + http_tunnel.public_url)
print('1. Start the swmdb container via Docker Dashboard')
print('2. Start the API')
print('3. Start the app')

try:
    # Block until CTRL-C or some other terminating event
    ngrok.get_ngrok_process().proc.wait()
except KeyboardInterrupt:
    print(" Shutting down server.")
    ngrok.kill()
