#!/usr/bin/env bash

echo ">>> Removing .direnv / .venv..."
rm -rf .direnv # in case you use direnv
rm -rf .venv

echo ">>> Creating venv..."
uv venv --python=3.10

echo ">>> Compiling..."
source .venv/bin/activate
uv pip compile -o requirements.txt requirements.in

echo ">>> Synchronizing..."
source .venv/bin/activate
uv pip sync requirements.txt

echo ">>> Running pyclean..."
source .venv/bin/activate
pyclean .

echo ">>> Running pytest..."
source .venv/bin/activate
pytest

echo ">>> Deactivating..."
deactivate
