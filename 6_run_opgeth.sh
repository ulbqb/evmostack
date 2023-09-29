#!/bin/bash

cd op-geth
./build/bin/geth \
        --datadir ./datadir \
        --http \
        --http.port=9545 \
        --http.corsdomain="*" \
        --http.vhosts="*" \
        --http.addr=0.0.0.0 \
        --http.api=web3,debug,eth,txpool,net,engine \
        --ws \
        --ws.addr=0.0.0.0 \
        --ws.port=9546 \
        --ws.origins="*" \
        --ws.api=debug,eth,txpool,net,engine \
        --syncmode=full \
        --gcmode=archive \
        --nodiscover \
        --maxpeers=0 \
        --networkid=42069 \
        --authrpc.vhosts="*" \
        --authrpc.addr=0.0.0.0 \
        --authrpc.port=9551 \
        --authrpc.jwtsecret=./jwt.txt \
        --rollup.disabletxpoolgossip=true > datadir/op-geth.log 2>&1 &