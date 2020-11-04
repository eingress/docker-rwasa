
# build

FROM alpine AS builder

ENV FASM_VERSION 1.73.25
ENV HEAVYTHING_VERSION 1.24

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
