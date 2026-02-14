# http-validation-server

A server for hosting ACME HTTP validation challenges.

## How to use

1. Check out the repo
2. Start the server with `swift run http-validation-server --port=<port> [<key>=<value> ...]`.
3. Access the server in a browser at `/` and add the key-value pairs to validate.

Key-value pairs can either be given at launch or by repeating step 3.
