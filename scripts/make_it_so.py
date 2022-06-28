import os
import sys
import hashlib
import fileinput
from pyngrok import ngrok
from dotenv import main

main.load_dotenv()

# pull changes from remote
api_repo = os.getenv("GIT_API")
app_repo = os.getenv("GIT_APP")

# Check for a change in the stored procedures and prompt
# Since there's no ARM support for sqlcmd the procedure query has to be run on a GUI client
with open(os.getenv("SQL_PATH"), 'rb') as f:
    new_hash = hashlib.md5()
    for chunk in iter(lambda: f.read(4096), b""):
        new_hash.update(chunk)
    if os.getenv("SQL_HASH") != new_hash.hexdigest():
        sys.exit("SQL hash difference.\nNew hash: " + new_hash.hexdigest())

# Open Docker and start the daemon
# Run the swm container

# Open an HTTPS tunnel on port 5003 with ngrok
http_tunnel = ngrok.connect("5003", bind_tls=True)

# Get the URL from ngrok without the protocol
public_url = http_tunnel.public_url[8:]

# Write the public ngrok URL to the pkg-mgmt .env file
pkg_env = os.getenv("PKG_ENV")
for line in fileinput.input(pkg_env, inplace=True):
    if "SERVER" in line:
        sys.stdout.write("SERVER=" + public_url + "\n")
    else:
        sys.stdout.write(line)

# Start the API
# Start the app
