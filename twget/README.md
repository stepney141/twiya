# twget

## これはなに

- wgetでtwitter webクライアントにログインしてbookmark apiを叩こうとし、結局失敗したものの成れの果て
- 2017年時点の情報によれば、当時はtwitterのログイン時に必要なトークンはtwitter.com/loginのhtmlに直接ベタ書きされていた。
よってこの時点では、トークンをgrepしてアカウント名とパスワードと一緒にpostしさえすれば、
その時に得られるcookieを読み込むことでシェル環境(wget)でもtwitterのログイン認証を突破できた。
- しかし2021年1月に試した所、トークンはtwitter.com/loginのjavascriptで動的に読み込まれるDOMツリー内に書き込まれるように仕様が変更されたらしく、
POSIXコマンドのみでログイン認証を突破することは出来なくなっていた。
- script.shを動かせば、2017年当時のtwitterであれば問題なくtwitterにログイン出来ていたはずである。
- wgetによるログインが頓挫したため、シェル環境のみで頑張るのではなくヘッドレスブラウザを利用してうまくやる方向へと方針転換した (= petter)
