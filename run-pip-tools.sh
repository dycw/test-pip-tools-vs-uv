#!/usr/bin/env bash

rm -rf .direnv # in case you use direnv
rm -rf .venv   # in case you use direnv
uv venv --python=3.11
source .venv/bin/activate
echo "---------"
which python
python --version
echo "---------"
pip install pip-tools
pip-compile
pip-sync
pytest ../test_main.py
deactivate
cd ..
