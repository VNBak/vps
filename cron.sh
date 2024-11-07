# vn30f
## monthly rolling
49,51 13 * * 5 cd /data/vn30f && robusta --mode=manage --method=trade.rolling --strategy=2
## momentum-vn30f
52,54 13 * * 1-5 cd /data/vn30f && USERNAME=vn30f screen -m -d robusta strategy
47,53 13,14 * * * screen -X quit
## daily backup
48 14 * * 1-5 cd /data/vn30f && robusta --mode=manage --method=db.backup && git pull && git add . && git commit -m "DB" && git push

# vn
## combine
57 6 17-29 2,5,8,11 * cd /data/vn && USERNAME=vni screen -m -d robusta --strategy=strategy/combine/ivq.js strategy
57 6 17-24 3,6,9,12 * cd /data/vn && USERNAME=vni screen -m -d robusta --strategy=strategy/combine/ivqa.js strategy
2 7 * * * pkill -f robusta
3 7 * * * cd /data/vn && robusta --mode=manage --method=db.backup && git pull && git add . && git commit -m "CBN" && git push
## strategy
37 14 * * 1-5 cd /data/vn && USERNAME=vni screen -m -d robusta strategy
49 14 * * * cd /data/vn && robusta --mode=manage --method=db.backup && git pull && git add . && git commit -m "DB" && git push
## etf-stocks-picker
11 9,15 * * 1-5 cd /data/vn && USERNAME=vni screen -m -d robusta strategy/combine/etf-stocks-picker.js
12 15 * * 1-5 cd /data/vn && USERNAME=vni screen -m -d robusta strategy/combine/notify.js
17 9,15 * * 1-5 pkill -f robusta
18 9,15 * * 1-5 cd /data/vn && robusta --mode=manage --method=db.backup && git pull && git add . && git commit -m "ETF" && git push
