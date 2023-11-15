
ARG SRC=python:3.12-alpine
FROM ${SRC} as build

WORKDIR /build

RUN apk add --no-cache gcc linux-headers libc-dev && \
    pip install --no-cache-dir wheel && \
    pip wheel diagrams

ARG SRC=python:3.12-alpine
FROM ${SRC} as target

WORKDIR /install

COPY --from=build /build/*.whl ./

RUN pip install --no-cache-dir *.whl && rm -rf /install/*.whl

RUN apk update && apk upgrade && apk add --no-cache graphviz

WORKDIR /work

