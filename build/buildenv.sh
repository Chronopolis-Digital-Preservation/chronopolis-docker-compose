#!/bin/bash
cp --no-preserve=ownership -r ../artifacts/chronopolishome ..
cp --no-preserve=ownership -r ../artifacts/postgresql ..
mkdir -p ../export/outgoing/bags
mkdir -p ../export/outgoing/tokens
mkdir -p ../scratch1/chronopolis-preservation
mkdir -p ../postgresql/data
