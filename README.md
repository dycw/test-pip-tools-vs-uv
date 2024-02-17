#

## Test 1: `pip-tools`

```bash
cd 1-pip-tools/
uv venv
source .venv/bin/activate
pip install pip-tools
pip-sync
pytest
cd ..
```

```console
└ ❯ pytest
=================================== test session starts ===================================
platform darwin -- Python 3.10.13, pytest-8.0.1, pluggy-1.4.0
rootdir: /Users/derek/work/test-pip-tools-vs-uv/1-pip-tools
collected 1 item

test_main.py .                                                                      [100%]

==================================== warnings summary =====================================
test_main.py::test_main
  /Users/derek/.pyenv/versions/3.10.13/lib/python3.10/site-packages/imageio_ffmpeg/_utils.py:7: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
    from pkg_resources import resource_filename

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html
============================== 1 passed, 1 warning in 7.04s ===============================
```

## Test 2: `pip-tools` with `filterwarnings`

```bash
cd 2-pip-tools-with-filterwarnings/
uv venv
source .venv/bin/activate
pip install pip-tools
pip-sync
pytest
cd ..
```

```console
└ ❯ pytest
=================================== test session starts ===================================
platform darwin -- Python 3.10.13, pytest-8.0.1, pluggy-1.4.0
rootdir: /Users/derek/work/test-pip-tools-vs-uv/2-pip-tools-with-filterwarnings
configfile: pytest.ini
collected 1 item

test_main.py .                                                                      [100%]

==================================== 1 passed in 0.25s ====================================
```

## Test 3: `uv`

```bash
cd 3-uv/
uv venv
source .venv/bin/activate
uv pip sync requirements.txt
pytest
cd ..
```

```console
└ ❯ pytest
=================================== test session starts ===================================
platform darwin -- Python 3.10.13, pytest-8.0.1, pluggy-1.4.0
rootdir: /Users/derek/work/test-pip-tools-vs-uv/3-uv
collected 1 item

test_main.py .                                                                      [100%]

==================================== warnings summary =====================================
test_main.py::test_main
  /Users/derek/.pyenv/versions/3.10.13/lib/python3.10/site-packages/imageio_ffmpeg/_utils.py:7: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
    from pkg_resources import resource_filename

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html
============================== 1 passed, 1 warning in 0.21s ===============================
```

## Test 3: `uv` with `filterwarnings`

```bash
cd 3-uv-with-filterwarnings/
uv venv
source .venv/bin/activate
uv pip sync requirements.txt
pytest
cd ..
```

```console
└ ❯ pytest
=================================== test session starts ===================================
platform darwin -- Python 3.10.13, pytest-8.0.1, pluggy-1.4.0
rootdir: /Users/derek/work/test-pip-tools-vs-uv/3-uv
collected 1 item

test_main.py .                                                                      [100%]

==================================== warnings summary =====================================
test_main.py::test_main
  /Users/derek/.pyenv/versions/3.10.13/lib/python3.10/site-packages/imageio_ffmpeg/_utils.py:7: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
    from pkg_resources import resource_filename

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html
============================== 1 passed, 1 warning in 0.21s ===============================
```
