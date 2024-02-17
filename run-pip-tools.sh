#!/usr/bin/env bash

echo ">>> Removing .direnv / .venv..."
rm -rf .direnv # in case you use direnv
rm -rf .venv

echo ">>> Creating venv..."
PYENV_VERSION=3.10 python -m venv .venv

echo ">>> Installing pip-tools..."
source .venv/bin/activate
pip install pip-tools

echo ">>> Compiling..."
source .venv/bin/activate
pip-compile

echo ">>> Synchronizing..."
source .venv/bin/activate
pip-sync

echo ">>> Running pyclean..."
source .venv/bin/activate
pyclean .

echo ">>> Running pytest..."
source .venv/bin/activate
pytest

echo ">>> Deactivating..."
deactivate
