#!/bin/bash
geth --datadir ~/g/GethData \
  --networkid 571 \
  --http \
  --http.addr "0.0.0.0" \
  --http.port 8545 \
  --http.api "db,eth,net,web3,personal,miner" \
  --mine \
  --miner.etherbase 0xdd6342cD45CE437382C00523cc6F22968bdd21b8 \
  --http.corsdomain "*" \
  --ipcpath ~/g/GethData/geth.ipc \
  --http.vhosts "*" \
  --port 30303 \
  --allow-insecure-unlock \
  --nodiscover \
  --verbosity 3 \
  --syncmode "full" \
  --gcmode "archive"
