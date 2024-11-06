# vn30f
## monthly rolling
49,51 6 * * 5 cd /data/vn30f && robusta --mode=manage --method=trade.rolling --strategy=2
## momentum-vn30f
52,54 6 * * 1-5 cd /data/vn30f && USERNAME=vn30f screen -m -d robusta strategy
47,53 6,7 * * * screen -X quit
## daily backup
48 7 * * 1-5 cd /data/vn30f && robusta --mode=manage --method=db.backup && git pull && git add . && git commit -m "DB" && git push

# vn
## combine
57 23 16-28 2,5,8,11 * cd /data/vn && USERNAME=vni screen -m -d robusta --strategy=strategy/combine/ivq.js strategy
57 23 16-23 3,6,9,12 * cd /data/vn && USERNAME=vni screen -m -d robusta --strategy=strategy/combine/ivqa.js strategy
2 0 * * * pkill -f robusta
3 0 * * * cd /data/vn && robusta --mode=manage --method=db.backup && git pull && git add . && git commit -m "CBN" && git push
## strategy
37 7 * * 1-5 cd /data/vn && USERNAME=vni screen -m -d robusta strategy
48 7 * * * cd /data/vn && robusta --mode=manage --method=db.backup && git pull && git add . && git commit -m "DB" && git push
## etf-stocks-picker
11 2,8 * * 1-5 cd /data/vn && USERNAME=vni screen -m -d robusta strategy/combine/etf-stocks-picker.js
12 8 * * 1-5 cd /data/vn && USERNAME=vni screen -m -d robusta strategy/combine/notify.js
17 2,8 * * 1-5 pkill -f robusta
18 2,8 * * 1-5 cd /data/vn && robusta --mode=manage --method=db.backup && git pull && git add . && git commit -m "ETF" && git push
