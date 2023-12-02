
###############################################################################
# Microsoft Edge
###############################################################################

if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Edge\Extensions")) { 
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Edge\Extensions" -Type Folder | Out-Null 
}

if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Edge\Extensions\pdffhmdngciaglkoonimfcmckehcpafo")) { 
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Edge\Extensions\pdffhmdngciaglkoonimfcmckehcpafo" -Type Folder | Out-Null 
}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Edge\Extensions\pdffhmdngciaglkoonimfcmckehcpafo" "update_url" "https://edge.microsoft.com/extensionwebstorebase/v1/crx"

if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Edge\Extensions\opgbiafapkbbnbnjcdomjaghbckfkglc")) { 
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Edge\Extensions\opgbiafapkbbnbnjcdomjaghbckfkglc" -Type Folder | Out-Null 
}
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Edge\Extensions\opgbiafapkbbnbnjcdomjaghbckfkglc" "update_url" "https://edge.microsoft.com/extensionwebstorebase/v1/crx"

###############################################################################
# Google Chrome
###############################################################################

if (!(Test-Path "HKCU:\SOFTWARE\Google\Chrome\Extensions")) { 
    New-Item -Path "HKCU:\SOFTWARE\Google\Chrome\Extensions" -Type Folder | Out-Null 
}

if (!(Test-Path "HKCU:\SOFTWARE\Google\Chrome\Extensions\oboonakemofpalcgghocfoadofidjkkk")) { 
    New-Item -Path "HKCU:\SOFTWARE\Google\Chrome\Extensions\oboonakemofpalcgghocfoadofidjkkk" -Type Folder | Out-Null 
}
Set-ItemProperty "HKCU:\SOFTWARE\Google\Chrome\Extensions\oboonakemofpalcgghocfoadofidjkkk" "update_url" "https://clients2.google.com/service/update2/crx"

if (!(Test-Path "HKCU:\SOFTWARE\Google\Chrome\Extensions\idgpnmonknjnojddfkpgkljpfnnfcklj")) { 
    New-Item -Path "HKCU:\SOFTWARE\Google\Chrome\Extensions\idgpnmonknjnojddfkpgkljpfnnfcklj" -Type Folder | Out-Null 
}
Set-ItemProperty "HKCU:\SOFTWARE\Google\Chrome\Extensions\idgpnmonknjnojddfkpgkljpfnnfcklj" "update_url" "https://clients2.google.com/service/update2/crx"

###############################################################################
# Firefox
###############################################################################

# Not supported
