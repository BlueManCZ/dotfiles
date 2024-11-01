#!/usr/bin/env bash

# Connect to SAML authenticated VPN.
# | https://github.com/adrienverge/openfortivpn
# | https://github.com/gm-vm/openfortivpn-webview

cd "${HOME}/GitHub clones/openfortivpn-webview/openfortivpn-webview-electron"
npm start -- --url "https://sslvpn.tescosw.cz/remote/saml/start" | grep SVPNCOOKIE >/tmp/SVPNCOOKIE.txt
export $(cat /tmp/SVPNCOOKIE.txt)
pkexec openfortivpn sslvpn.tescosw.cz --cookie $SVPNCOOKIE
