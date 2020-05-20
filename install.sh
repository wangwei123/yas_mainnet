#!/bin/bash

EOSIO=eosio-2.0.5-1.el7.x86_64.rpm

wget https://github.com/EOSIO/eos/releases/download/v2.0.5/$EOSIO

yum install $EOSIO -y

rm -rf $EOSIO
