FROM abhishekchak52/palace_env:latest

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libblas-dev \
    liblapack-dev \
    libopenblas-dev \
    liblapacke-dev \
    liblapacke-dev

# Copy uv from astral-sh/uv:0.11.2
COPY --from=ghcr.io/astral-sh/uv:0.11.2 /uv /uvx /bin/


WORKDIR /app

# Install dependencies
# RUN --mount=type=cache,target=/root/.cache/uv \
# --mount=type=bind,source=uv.lock,target=uv.lock \
# --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
# uv sync -vvvv --locked --no-install-project


COPY --chown=ubuntu:ubuntu . /app
# Sync the project
# RUN --mount=type=cache,target=/root/.cache/uv \
# uv sync --locked

USER ubuntu

CMD ["bash"]