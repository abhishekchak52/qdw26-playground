FROM abhishekchak52/palace_env:latest

RUN apt-get update && apt-get install -y git 

# Copy uv from astral-sh/uv:0.11.2
COPY --from=ghcr.io/astral-sh/uv:0.11.2 /uv /uvx /bin/

ENV UV_LINK_MODE=copy
ENV UV_PYTHON_INSTALL_DIR=/opt/uv-python

WORKDIR /home/ubuntu/qdw26-playground

RUN uv python install 3.12

# Install dependencies
RUN --mount=type=cache,target=/home/ubuntu/.cache/uv \
--mount=type=bind,source=uv.lock,target=uv.lock \
--mount=type=bind,source=pyproject.toml,target=pyproject.toml \
uv sync --locked --no-install-project

# Source is bind-mounted at runtime (see compose.yaml). Run `uv sync --locked` there
# to install the project into the mounted tree's .venv (e.g. compose `command`).

RUN chown -R ubuntu:ubuntu /home/ubuntu/qdw26-playground /opt/uv-python

ENV PATH="/home/ubuntu/qdw26-playground/.venv/bin:$PATH"


USER ubuntu
