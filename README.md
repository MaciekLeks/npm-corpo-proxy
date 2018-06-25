npm-corpo-proxy bash script for those who work behind a corporate web proxy and want to use remote npm operations, e.g. npm install.

### Prerequisites:
1. npm installed
2. web proxy server host and port is known (if .pac file is used then open it and find ip and port of the web server)
3. domain name, user name and password may contain special chars
4. execution permission granted, e.g.:
```bash
chmod u+x npm-corpo-proxy.sh
```
### Simple usage
To use the script you gave to give some arguments:
```bash
npm-domain-proxy.sh on|off [domain] [user] [passwd] [host:port]
```

### Example:
Turn on proxy settings for npm:
```bash
npm-corpo-proxy.sh on mydomain user123 passwdord123 126.192.0.1:9090
```

Now, do your job with npm and at the end turn off proxy settings:
```bash
npm-corpo-proxy.sh off
```



