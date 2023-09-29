#!/bin/bash

cd optimism/op-node
./bin/op-node \
        --l2=http://localhost:9551 \
        --l2.jwt-secret=./jwt.txt \
        --sequencer.enabled \
        --sequencer.l1-confs=3 \
        --verifier.l1-confs=3 \
        --rollup.config=./rollup.json \
        --rpc.addr=0.0.0.0 \
        --rpc.port=9547 \
        --p2p.disable \
        --rpc.enable-admin \
        --p2p.sequencer.key=b00c9096eebc0c1a023fa9b6ae9df984007b2bb11cf1477002bc31b6ae72fac8 \
        --l1=http://localhost:8545 \
        --l1.rpckind=any
