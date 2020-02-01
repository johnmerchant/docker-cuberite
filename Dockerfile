FROM alpine:edge AS base

RUN apk add musl libgcc libstdc++ 

FROM base AS build

ENV LDFLAGS=-Wl,-z,stack-size=4194304

RUN apk add g++ git curl make cmake && \
	sh -c "$(curl -sSfL -o - https://compile.cuberite.org)" -s -m Release -t 4

FROM base

MAINTAINER "John Merchant <john@jmercha.dev>"

WORKDIR /cuberite

COPY --from=build /cuberite/build-cuberite/Server /cuberite/Server/ ./

VOLUME /cuberite

EXPOSE 8080 25565 25565/udp

ENTRYPOINT ["./Cuberite"]
