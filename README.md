# Edit 1

Now I cannot reproduce the bug in case 4. This is Heisenberg-like.

For more details, see below please.

# Original

This repo demonstrates some difference with `pip-tools` and `uv` with respect to
`pytest` and docstrings containing _invalid escape strings_. Here we run 4
tests:

- (`pip-tools` or `uv`) and (no `filterwarnings` or with `filterwarnings`)

In the last case, `uv` with `filterwarnings`, we trigger a `SyntaxError` upon
reading the module docstring in
https://github.com/Zulko/moviepy/blob/v1.0.3/moviepy/config_defaults.py with
contains the text
`IMAGEMAGICK_BINARY = r"C:\Program Files\ImageMagick-6.8.8-Q16\magick.exe"`.
Needlesstosay, this blocks testing.

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

## Test 4: `uv` with `filterwarnings`

```bash
cd 4-uv-with-filterwarnings/
uv venv
source .venv/bin/activate
uv pip sync requirements.txt
pytest
cd ..
```

```console
└ ❯ pytest
=================================== test session starts ===================================
platform darwin -- Python 3.11.7, pytest-8.0.1, pluggy-1.4.0
rootdir: /Users/derek/work/test-pip-tools-vs-uv/4-uv-with-filterwarnings
configfile: pytest.ini
collected 1 item

test_main.py F                                                                      [100%]

======================================== FAILURES =========================================
________________________________________ test_main ________________________________________

    def test_main():
>       from moviepy.editor import AudioFileClip, ColorClip, CompositeVideoClip, ImageClip

test_main.py:2:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
.venv/lib/python3.11/site-packages/moviepy/editor.py:36: in <module>
    from .video.io.VideoFileClip import VideoFileClip
.venv/lib/python3.11/site-packages/moviepy/video/io/VideoFileClip.py:3: in <module>
    from moviepy.audio.io.AudioFileClip import AudioFileClip
.venv/lib/python3.11/site-packages/moviepy/audio/io/AudioFileClip.py:3: in <module>
    from moviepy.audio.AudioClip import AudioClip
.venv/lib/python3.11/site-packages/moviepy/audio/AudioClip.py:7: in <module>
    from moviepy.audio.io.ffmpeg_audiowriter import ffmpeg_audiowrite
.venv/lib/python3.11/site-packages/moviepy/audio/io/ffmpeg_audiowriter.py:7: in <module>
    from moviepy.config import get_setting
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

    import os
    import subprocess as sp

    from .compat import DEVNULL
>   from .config_defaults import FFMPEG_BINARY, IMAGEMAGICK_BINARY
E     File "/Users/derek/work/test-pip-tools-vs-uv/4-uv-with-filterwarnings/.venv/lib/python3.11/site-packages/moviepy/config_defaults.py", line 1
E       """
E       ^^^
E   SyntaxError: invalid escape sequence '\P'

.venv/lib/python3.11/site-packages/moviepy/config.py:5: SyntaxError
================================= short test summary info =================================
FAILED test_main.py::test_main -   File "/Users/derek/work/test-pip-tools-vs-uv/4-uv-with-filterwarnings/.venv/lib/pyth...
==================================== 1 failed in 0.28s ====================================
```


# Edit 1

For what it's worth, I am still running to this in my main project as I switch from `pip-tools` to `uv`; this is what motivated scooping this out in the first place. Here's my traceback:

```console
└ ❯ pytest src/tests/test_videoify.py
=================================== test session starts ===================================
platform darwin -- Python 3.10.13, pytest-8.0.0, pluggy-1.4.0
Using --randomly-seed=1994042180
rootdir: /Users/derek/work/myproject
configfile: pyproject.toml
plugins: instafail-0.5.0, hypothesis-6.98.6, randomly-3.15.0, only-2.0.0, xdist-3.5.0, anyio-4.2.0
collected 0 items / 1 error

========================================= ERRORS ==========================================
_______________________ ERROR collecting src/tests/test_videoify.py _______________________
.venv/lib/python3.10/site-packages/_pytest/python.py:537: in importtestmodule
    mod = import_path(path, mode=importmode, root=config.rootpath)
.venv/lib/python3.10/site-packages/_pytest/pathlib.py:567: in import_path
    importlib.import_module(module_name)
../../.pyenv/versions/3.10.13/lib/python3.10/importlib/__init__.py:126: in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
<frozen importlib._bootstrap>:1050: in _gcd_import
    ???
<frozen importlib._bootstrap>:1027: in _find_and_load
    ???
<frozen importlib._bootstrap>:1006: in _find_and_load_unlocked
    ???
<frozen importlib._bootstrap>:688: in _load_unlocked
    ???
.venv/lib/python3.10/site-packages/_pytest/assertion/rewrite.py:175: in exec_module
    exec(co, module.__dict__)
src/tests/test_videoify.py:8: in <module>
    from my_project.videoify.core import _videoify_files
src/my_project/videoify/core.py:11: in <module>
    from moviepy.editor import AudioFileClip, ColorClip, CompositeVideoClip, ImageClip
.venv/lib/python3.10/site-packages/moviepy/editor.py:60: in <module>
    from .video.io.sliders import sliders
E     File "/Users/derek/work/my_project/.venv/lib/python3.10/site-packages/moviepy/video/io/sliders.py", line 61
E       if event.key is 'enter':
E          ^^^^^^^^^^^^^^^^^^^^
E   SyntaxError: "is" with a literal. Did you mean "=="?
!!!!!!!!!!!!!!!!!!!!!!!!! Interrupted: 1 error during collection !!!!!!!!!!!!!!!!!!!!!!!!!!
==================================== 1 error in 4.67s =====================================
```

I understand these used to be `SyntaxWarning`s, but, how come everything is being flagged now?
