#!/usr/bin/env bash

rm -rf .direnv # in case you use direnv
rm -rf .venv   # in case you use direnv
uv venv --python=3.11
source .venv/bin/activate
echo "---------"
which python
python --version
echo "---------"
uv pip compile -o requirements.txt requirements.in
uv pip sync requirements.txt
pytest ../test_main.py
deactivate
cd ..
