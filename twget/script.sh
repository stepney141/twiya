#!/bin/bash

## 参考：https://yuinore.net/2017/08/wget-diary/

ua="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:84.0) Gecko/20100101 Firefox/84.0"

wget \
--no-check-certificate \
--keep-session-cookies \
--save-cookies=twitter-cookie-login.txt \
--user-agent="$ua" \
--debug \
-E https://twitter.com/login?lang=ja \
-O login.html

username=@example
pass=password
# token=`cat login.html | grep -oP '(?<="featureSetToken":).+?(=*")' | tr -d '"'`
token=echo `cat login.html | grep -oP '(?<=input name="authenticity_token" type="hidden" value=").+?(?=")'` | cut -c-33
postdata="redirect_after_login=/&remember_me=1&authenticity_token=$token&session[username_or_email]=$username&session[password]=$pass"

wget \
--no-check-certificate \
--keep-session-cookies \
--load-cookies=twitter-cookie-login.txt \
--save-cookies=twitter-cookie-session.txt \
--user-agent="$ua" \
--debug \
--post-data="$postdata" \
-E https://twitter.com/sessions \
-O sessions.html

# load twitter-cookie-session.txt for signing-in
