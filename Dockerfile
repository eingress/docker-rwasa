
# build

FROM alpine:latest AS builder

ARG FASM_VERSION
ARG HEAVYTHING_VERSION

RUN apk --update --no-cache add binutils curl && \
	curl -sL "https://flatassembler.net/fasm-$FASM_VERSION.tgz" | tar xz && \
	ln -s /fasm/fasm /bin/fasm

WORKDIR /build

COPY build.sh ./build.sh

RUN chmod +x ./build.sh
RUN ./build.sh $HEAVYTHING_VERSION

# release

FROM scratch
LABEL maintainer "Scott Mathieson <scott@eingress.io>"

COPY root /
COPY --from=builder /build/rwasa /

ENTRYPOINT ["/rwasa"]

CMD ["-bind", "80", "-foreground", "-sandbox", "/var/www"]
