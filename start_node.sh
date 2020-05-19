#!/bin/bash 

provider_name="节点账号"
provider_publickey="节点公钥"
provider_privatekey="节点私钥"

PID=$(ps -ef | grep "nodeos" | grep -v grep | awk '{print $2}')
if [ -n "$PID" ];then
  echo "killall nodeos..."
  killall nodeos
fi

#--delete-all-blocks 

echo "starting nodeos..."
nodeos --genesis-json genesis.json \
-p $provider_name \
--signature-provider "$provider_publickey=KEY:$provider_privatekey" \
--p2p-peer-address rpc.yas.plus:10277 \
--p2p-peer-address 198.13.51.191:9876 \
--p2p-peer-address 98.74.53.102:9876 \
--p2p-peer-address 172.105.84.51:9876 \
--p2p-peer-address 85.159.211.82:9876 \
--p2p-peer-address 172.104.66.128:9876 \
--p2p-peer-address 172.105.19.253:9876 \
--p2p-peer-address 149.28.35.57:9876 \
--plugin eosio::producer_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::state_history_plugin \
--disable-replay-opts \
--http-server-address 127.0.0.1:8888 \
--sync-fetch-span 100000 \
--wasm-runtime eos-vm-jit \
--http-validate-host=false \
-d ~/data >> nodeos.log 2>&1 &


PID=$(ps -ef | grep "nodeos" | grep -v grep | awk '{print $2}')
if [ -n "$PID" ];then
  echo "start nodeos success!"
fi
