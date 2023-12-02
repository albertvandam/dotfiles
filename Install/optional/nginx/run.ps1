# C:\Windows\System32\drivers\etc\hosts

#  I set "iptables": false in /etc/docker/daemon.json.
# {
    # "iptables": false
# }

docker container rm nginx-proxy
docker rmi nginx-proxy

$certfile = "$HOME\.config\Install\optional\nginx\nginx-selfsigned.crt"
if (![System.IO.File]::Exists($certFile)) { 
    ubuntu run "openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/DC=com/DC=host/DC=work/UID=123456+CN=work.host.com' -keyout nginx-selfsigned.key -out nginx-selfsigned.crt"
}

docker build -t nginx-proxy .
docker run -p 443:443 -p 80:80 -d --name nginx-proxy nginx-proxy
docker ps
