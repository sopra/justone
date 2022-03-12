FROM rust:alpine AS build

COPY . /root/
WORKDIR /root/
RUN apk add musl-dev && \
    cargo build --release --verbose

# --------
FROM alpine:latest AS runtime

RUN mkdir /app
WORKDIR /app
COPY ./include /app/include
COPY --from=build /root/target/release/justone /app/justone
CMD [ "/app/justone",  "--port", "${PORT}"]