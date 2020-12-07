FROM alpine:3.10 AS build
RUN apk add gcc g++ zlib-dev libc-dev curl make bzip2
WORKDIR /build
RUN curl -OL https://github.com/fritzsedlazeck/SURVIVOR/archive/v1.0.6.tar.gz
RUN tar xzf v1.0.6.tar.gz
RUN ls /build
WORKDIR /build/SURVIVOR-1.0.6
RUN make -C Debug

FROM alpine:3.10
RUN apk add bash bzip2 zlib
COPY --from=build /build/SURVIVOR-1.0.6/Debug/SURVIVOR /usr/local/bin
COPY --from=build /build/SURVIVOR-1.0.6/INSTALL /
COPY --from=build /build/SURVIVOR-1.0.6/README.md /
COPY --from=build /build/SURVIVOR-1.0.6/LICENSE /
