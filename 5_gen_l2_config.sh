#!/bin/bash

source /root/.bashrc
source /root/.cargo/env

cd optimism/op-node

go run cmd/main.go genesis l2 \
    --deploy-config ../packages/contracts-bedrock/deploy-config/getting-started.json \
    --deployment-dir ../packages/contracts-bedrock/deployments/getting-started/ \
    --outfile.l2 genesis.json \
    --outfile.rollup rollup.json \
    --l1-rpc http://localhost:8545

openssl rand -hex 32 > jwt.txt

cp genesis.json ../../op-geth
cp jwt.txt ../../op-geth
