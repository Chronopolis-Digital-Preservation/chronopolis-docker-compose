#!/bin/bash
cp --no-preserve=ownership -R ../artifacts/chronopolishome ..
cp --no-preserve=ownership -R ../artifacts/postgresql ..
mkdir -p ../export/outgoing/bags
mkdir -p ../export/outgoing/tokens
mkdir -p ../scratch1/chronopolis-preservation
mkdir -p ../postgresql/data
