#!/bin/sh

for i in *; do mv "$i" "`echo $i | tr [:upper:] [:lower:]`"; done
