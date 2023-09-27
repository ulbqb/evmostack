#!/bin/bash

docker run --name evmostack -itd -v ${PWD}:/workspace -w /workspace debian:bullseye bash
docker exec -it evmostack apt update
docker exec -it evmostack apt upgrade -y
docker exec -it evmostack bash
