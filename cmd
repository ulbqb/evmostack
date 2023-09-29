#!/bin/bash

evmos_log() {
  tail -f ~/.tmp-evmosd/evmos_9000-1.log 
}

balances() {
  echo "faucet balance:"
  evmosd --home ~/.tmp-evmosd/ query bank balances evmos17w0adeg64ky0daxwd2ugyuneellmjgnxpu2u3g
  echo "admin balances:"
  evmosd --home ~/.tmp-evmosd/ query bank balances evmos14ep84s8g0xqj8fpanfm5xzs2vyfwvqfqxkeqx5
  echo "proposer balances:"
  evmosd --home ~/.tmp-evmosd/ query bank balances evmos1sxsdvkq9fn2udk5jp449seq3adz5gu6fsv3dck
  echo "batcher balances:"
  evmosd --home ~/.tmp-evmosd/ query bank balances evmos1z3flnp7h48rxx3ppjmccerxmv4w3hnxkwan94l
  echo "sequencer balances:"
  evmosd --home ~/.tmp-evmosd/ query bank balances evmos160cwdaz3mrc8mlj9eqhd5w6zafk5yq3fy859ez
}

faucet() {
  evmosd --home ~/.tmp-evmosd/ tx bank multi-send dev0 evmos14ep84s8g0xqj8fpanfm5xzs2vyfwvqfqxkeqx5 evmos1sxsdvkq9fn2udk5jp449seq3adz5gu6fsv3dck evmos1z3flnp7h48rxx3ppjmccerxmv4w3hnxkwan94l evmos160cwdaz3mrc8mlj9eqhd5w6zafk5yq3fy859ez 10000000000000000000000aevmos -fees 1400000aevmos --keyring-backend test --chain-id evmos_9000-1
}

kill() {
  pkill evmosd
  pkill geth
}

case $1 in
  "evmoslog")
    evmos_log
    ;;
  "balances")
    balances
    ;;
  "faucet")
    faucet
    echo "result"
    balances
    ;;
  "kill")
    kill
    ;;
  *)
    echo '
commands:
evmoslog      show evmos log
balances      show user balances
faucet        send some token to users
kill          kill process
'
    ;;
esac
