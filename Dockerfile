FROM alpine AS base

FROM base AS build

RUN apk add curl g++ git make cmake && \
	sh -c "$(curl -sSfL -o - https://compile.cuberite.org)" -s -m Release -t 4


