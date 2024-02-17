#!/usr/bin/env bash

rm -rf .direnv # in case you use direnv
rm -rf .venv   # in case you use direnv
uv venv
source .venv/bin/activate
echo "---------"
which python
python --version
echo "---------"
uv pip sync requirements.txt
pytest
cd ..