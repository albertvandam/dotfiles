
$dom = $env:userdomain
$usr = $env:username
([adsi]"WinNT://$dom/$usr,user").fullname
