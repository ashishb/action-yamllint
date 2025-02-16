FROM python:3-alpine AS base

RUN apk add --no-cache bash gcc musl-dev && \
    pip install --root /yamllint 'yamllint>=1.25.0' && \
    rm -rf ~/.cache/pip

FROM python:3-alpine AS builder

COPY --from=base /yamllint /yamllint
ENV PATH="/yamllint/usr/local/bin:${PATH}"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
