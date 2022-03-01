#!/bin/bash

sphinx-build -M latexpdf source build

cp build/latex/cpp_ptb.pdf cpp_ptb-manual.pdf
