#!/bin/zsh

if [ -f ~/.local/zsh_config/location.env ]; then
    source ~/.local/zsh_config/location.env
else
    LOCATION=""
fi

curl -s "http://wttr.in/$LOCATION?0" --silent >/tmp/weather-now.tmp
if [[ -s /tmp/weather-now.tmp ]]; then
    DATE=`date -R`
    /bin/cat /tmp/weather-now.tmp | sed -E "s/Weather report: (.*)$/Weather report: ${LOCATION}\nLast updated: ${DATE}/g" >/tmp/weather-now
fi
/bin/rm /tmp/weather-now.tmp 2>/dev/null

curl -s "http://wttr.in/$LOCATION?format=%l+%c%f\n" --silent >/tmp/weather-line.tmp
if [[ -s /tmp/weather-line.tmp ]]; then
    /bin/mv /tmp/weather-line.tmp /tmp/weather-line
fi
/bin/rm /tmp/weather-line.tmp 2>/dev/null

echo ""
