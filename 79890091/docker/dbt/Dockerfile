FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential libffi-dev libssl-dev git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir "dbt-core>=1.7.15" "dbt-starrocks>=1.7.0"

WORKDIR /usr/app

# ENTRYPOINT ["/bin/bash"]
