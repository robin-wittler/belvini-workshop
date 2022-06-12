FROM debian:11-slim as build_image
LABEL maintainer="Robin Wittler <robin.wittler@gmail.com>"
RUN apt-get update && \
    apt-get install \
      --no-install-suggests \
      --no-install-recommends \
      --yes \
      python3-venv \
      gcc \
      libpython3-dev && \
    python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip setuptools wheel


FROM build_image as build_venv
LABEL maintainer="Robin Wittler <robin.wittler@gmail.com>"
COPY ./setup.py ./requirements.txt /tmp/
WORKDIR /tmp
RUN /venv/bin/pip install --disable-pip-version-check .


FROM gcr.io/distroless/python3-debian11
LABEL maintainer="Robin Wittler <robin.wittler@gmail.com>"
COPY --from=build_venv /venv /venv
COPY ./main.py /
ENV PYTHONPATH="/venv/lib/python3.9/site-packages"
USER nonroot

