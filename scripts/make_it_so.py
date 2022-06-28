# from dotenv import load_env
from pyngrok import ngrok
import os

# load_dotenv()
# pull changes from remote

# Open Docker and start the daemon
# Run the swm container

# Check for a change in the stored procedures and prompt
# Since there's no ARM support for sqlcmd the procedure query has to be run on a GUI client

# Open an HTTPS tunnel on port 5003 with ngrok
http_tunnel = ngrok.connect("5003", bind_tls=True)

# Get the URL from ngrok without the protocol
public_url = http_tunnel.public_url[8:]
pkg_env = "~/dev/pkg-mgmt/assets/.env"

with open(pkg_env, 'r+') as file:
    # read a list of lines into data
    lines = file.readlines()
    new_lines = []
    for line in lines:
        new_lines.append(line)
        if "SERVER" in line:
            print('found: ', line)
            new_lines.append("SERVER="+public_url)
    file.writelines(new_lines)

# Write the public ngrok URL to the pkg-mgmt .env file


# Start the API
# Start the app
