#!/bin/bash

mkdir -p tmp

apt install -y git curl make jq wget ca-certificates gnupg bc build-essential python3 procps

if [ ! -f "tmp/go1.20.linux-arm64.tar.gz" ]; then
    wget https://go.dev/dl/go1.20.linux-arm64.tar.gz -P ./tmp
fi
tar -C /usr/local -xzf tmp/go1.20.linux-arm64.tar.gz
echo export PATH=$PATH:/usr/local/go/bin >> ~/.bashrc
source /root/.bashrc

mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
apt update
apt install -y nodejs

npm install -g pnpm
pnpm config set store-dir /root/.pnpm-store

curl https://sh.rustup.rs -sSf | sh -s -- -y
source "/root/.cargo/env"

curl -L https://foundry.paradigm.xyz | bash
source /root/.bashrc
foundryup -C 3b1129b5bc43ba22a9bcf4e4323c5a9df0023140 # see https://github.com/ethereum-optimism/optimism/blob/5877ee24cc9aaef5848c1372e0e196707fb336a0/package.json#L33

if [ ! -f "tmp/evmos_14.1.0_Linux_arm64.tar.gz" ]; then
    wget https://github.com/evmos/evmos/releases/download/v14.1.0/evmos_14.1.0_Linux_arm64.tar.gz -P ./tmp
fi
tar -C /usr/local -xzf tmp/evmos_14.1.0_Linux_arm64.tar.gz

if [ ! -d "optimism" ]; then
    git clone https://github.com/ethereum-optimism/optimism.git
fi
cd optimism && git checkout v1.1.4 && cd ..

if [ ! -d "op-geth" ]; then
    git clone https://github.com/ethereum-optimism/op-geth.git
fi
cd op-geth && git checkout v1.101200.0 && cd ..

printf \
'Please check version:
golang      expected: 1.20              actual: %s
node        expected: 16.20.2           actual: %s
npm         expected: 8.19.4            actual: %s
pnpm        expected: 8.8.0             actual: %s
forge       expected: 0.2.0(3b1129b)    actual: %s
evmosd      expected: 14.1.0            actual: %s 
' "$(go version)" "$(node --version)" "$(npm --version)" "$(pnpm --version)" "$(forge --version)" "$(evmosd version)"
