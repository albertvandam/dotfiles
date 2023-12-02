#!/bin/sh

echo "Adding Browser Extensions"

###############################################################################
# Microsoft Edge
###############################################################################

if [ ! -d $HOME/Library/Application\ Support/Microsoft\ Edge/External\ Extensions ]; then
    mkdir -p $HOME/Library/Application\ Support/Microsoft\ Edge/External\ Extensions
fi

echo "{ \"external_update_url\": \"https://edge.microsoft.com/extensionwebstorebase/v1/crx\" }" >$HOME/Library/Application\ Support/Microsoft\ Edge/External\ Extensions/pdffhmdngciaglkoonimfcmckehcpafo.json
chmod 600 $HOME/Library/Application\ Support/Microsoft\ Edge/External\ Extensions/pdffhmdngciaglkoonimfcmckehcpafo.json

echo "{ \"external_update_url\": \"https://edge.microsoft.com/extensionwebstorebase/v1/crx\" }" >$HOME/Library/Application\ Support/Microsoft\ Edge/External\ Extensions/opgbiafapkbbnbnjcdomjaghbckfkglc.json
chmod 600 $HOME/Library/Application\ Support/Microsoft\ Edge/External\ Extensions/opgbiafapkbbnbnjcdomjaghbckfkglc.json

###############################################################################
# Google Chrome
###############################################################################

if [ ! -d $HOME/Library/Application\ Support/Google/Chrome/External\ Extensions ]; then
    mkdir -p $HOME/Library/Application\ Support/Google/Chrome/External\ Extensions
fi

echo "{ \"external_update_url\": \"https://clients2.google.com/service/update2/crx\" }" >$HOME/Library/Application\ Support/Google/Chrome/External\ Extensions/oboonakemofpalcgghocfoadofidjkkk.json
chmod 600 $HOME/Library/Application\ Support/Google/Chrome/External\ Extensions/oboonakemofpalcgghocfoadofidjkkk.json

echo "{ \"external_update_url\": \"https://clients2.google.com/service/update2/crx\" }" >$HOME/Library/Application\ Support/Google/Chrome/External\ Extensions/idgpnmonknjnojddfkpgkljpfnnfcklj.json
chmod 600 $HOME/Library/Application\ Support/Google/Chrome/External\ Extensions/idgpnmonknjnojddfkpgkljpfnnfcklj.json

###############################################################################
# Firefox
###############################################################################

# Not supported
