#!/bin/bash

source /root/.bashrc
source /root/.cargo/env

export ETH_RPC_URL=http://localhost:8545
export PRIVATE_KEY=ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export DEPLOYMENT_CONTEXT=getting-started

cp data/getting-started.json optimism/packages/contracts-bedrock/deploy-config/getting-started.json
cd optimism
cd packages/contracts-bedrock
FINBLOCK=$(cast block finalized -f number)
sed "s/TIMESTAMP/$(cast block $FINBLOCK -f timestamp)/g" deploy-config/getting-started.json > deploy-config/getting-started-tmp.json
sed "s/BLOCKHASH/$(cast block $FINBLOCK -f hash)/g" deploy-config/getting-started-tmp.json > deploy-config/getting-started.json
rm deploy-config/getting-started-tmp.json
mkdir -p deployments/getting-started
forge script scripts/Deploy.s.sol:Deploy --private-key $PRIVATE_KEY --broadcast --rpc-url $ETH_RPC_URL --slow
forge script scripts/Deploy.s.sol:Deploy --sig 'sync()' --private-key $PRIVATE_KEY --broadcast --rpc-url $ETH_RPC_URL
