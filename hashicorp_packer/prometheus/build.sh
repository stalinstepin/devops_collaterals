#!/bin/bash
(cd files/ && tar -zcvf files.tar.gz *)
packer fmt .
packer validate .
packer build -var-file=variables.pkrvars.hcl main.pkr.hcl
(cd files/ && rm -rf files.tar.gz)