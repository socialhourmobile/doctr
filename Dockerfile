FROM python:3.8-slim

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1


COPY ./pyproject.toml /tmp/pyproject.toml
COPY ./README.md /tmp/README.md
COPY ./setup.py /tmp/setup.py
COPY ./doctr /tmp/doctr

RUN apt-get update \
    && apt-get install libgl1 \
    && apt-get install -y python3-opencv \
    && apt-get install ffmpeg libsm6 libxext6 -y \
    && pip install --upgrade pip setuptools wheel \
    && pip install -e /tmp/.[tf] \
    && pip cache purge \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /root/.cache/pip
