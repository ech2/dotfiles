#!/bin/bash

if [ `hostname` == "blank" ]; then
  xgamma -rgamma 1 -ggamma 0.94 -bgamma 0.9
fi
