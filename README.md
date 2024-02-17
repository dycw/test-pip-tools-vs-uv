#

This repo demonstrates some difference with `pip-tools` and `uv` with respect to `pytest` and docstrings containing _invalid escape strings_. Here we run 4 tests:

- (`pip-tools` or `uv`) and (no `filterwarnings` or with `filterwarnings`)

In the last case, `uv` with `filterwarnings`, we trigger a `SyntaxError` upon reading the module docstring in https://github.com/Zulko/moviepy/blob/v1.0.3/moviepy/config_defaults.py with contains the text `IMAGEMAGICK_BINARY = r"C:\Program Files\ImageMagick-6.8.8-Q16\magick.exe"`. Needlesstosay, this blocks testing.

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
rootdir: /Users/derek/work/test-pip-tools-vs-uv/2-pip-tools-with-filterwarnings
configfile: pytest.ini
collected 1 item

test_main.py .                                                                      [100%]

==================================== 1 passed in 0.24s ====================================
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
