#!/usr/bin/env bash

rm -rf .direnv # in case you use direnv
rm -rf .venv   # in case you use direnv
uv venv --python=3.10
source .venv/bin/activate
uv pip compile -o requirements.txt requirements.in
uv pip sync requirements.txt
echo "---------"
which python
python --version
which pytest
echo "---------"
pytest
deactivate
cd ..
