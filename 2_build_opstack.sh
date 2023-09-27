#!/bin/bash

source /root/.bashrc
source /root/.cargo/env

cd op-geth
make geth
cd ../

cd optimism
pnpm install
make op-node op-batcher op-proposer
pnpm build
