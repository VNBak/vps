#!/bin/sh

curl -fsSL https://raw.githubusercontent.com/VNBak/vps/HEAD/cron.sh | crontab -

apt update
apt install git unzip -y

echo '#!/bin/sh
echo username=$GIT_USERNAME
echo password=$GIT_PASSWORD' > /root/git.sh
chmod +x /root/git.sh
git config --global credential.helper /root/git.sh
git config --global user.name robusta
git config --global user.email rs@aicafe.one

cd /bin
wget -q -O - https://github.com/AICafe1/robusta-server/releases/latest/download/robusta-linux.tgz | tar -xz

cd /
if [ ! -d "robusta" ]; then
  mkdir robusta
  cd robusta
  wget -q https://github.com/AICafe1/robusta-server/releases/download/v1.0.0/vn.tgz.zip
  unzip -qpP $VNZIP vn.tgz.zip | tar -xz
  rm vn.tgz.zip
fi

if [ ! -d "/data" ]; then
  mkdir /data
fi
cd /data
if [ -d "strategy" ]; then
  cd strategy; git pull; cd ..
else
  git clone --depth=1 https://github.com/AICafe1/robusta-strategy.git strategy
fi

if [ -d "vn" ]; then
  cd vn
  git pull
else
  git clone --depth=1 https://github.com/VNBak/vn.git
  cd vn
  ln -s /robusta/csv .
  ln -s /data/strategy/combine/ivq.js strategy/combine/
  ln -s /data/strategy/combine/ivqa.js strategy/combine/
  ln -s /data/strategy/combine/notify.js strategy/combine/
  ln -s /data/strategy/etf-stocks-picker/index.js strategy/combine/etf-stocks-picker.js
  ln -s /data/strategy/momentum-vn100/index.js strategy/momentum-vn100/
  ln -s /data/strategy/risk-parity/index.js strategy/risk-parity/
  ln -s /data/strategy/risk-parity-hnx/index.js strategy/risk-parity-hnx/
  ln -s /data/strategy/ctck/index.js strategy/ctck/
  ln -s /data/strategy/value-vn100/index.js strategy/value-vn100/
  robusta --mode=manage --method=db.restore --force=1
fi

cd /data
if [ -d "vn30f" ]; then
  cd vn30f
  git pull
else
  git clone --depth=1 https://github.com/VNBak/vn30f.git
  cd vn30f
  ln -s /data/strategy/momentum-vn30f/index.js strategy/momentum-vn30f/
  ln -s /data/strategy/trend-vn30f/index.js strategy/trend-vn30f/
  robusta --mode=manage --method=db.restore --force=1
fi

cd /data/strategy
if [ ! -d "node_modules" ]; then
  ln -s ../vn30f/LICENSE.key
  NPM_CONFIG_UPDATE_NOTIFIER=false robusta --mode=npm i --omit=dev --prefer-offline --no-audit --progress=false
  rm LICENSE.key
fi
