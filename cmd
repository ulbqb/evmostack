#!/bin/bash

evmos_log() {
  tail -f ~/.tmp-evmosd/evmos_9000-1.log 
}

case $1 in
   "evmoslog")
      evmos_log
      ;;
   *)
     echo '
commands:
evmoslog      show evmos log
'
     ;;
esac
