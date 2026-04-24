FROM lukemathwalker/cargo-chef:0.1.77-rust-1.95 AS chef
WORKDIR /app

FROM chef AS planner
COPY Cargo.toml Cargo.lock ./
COPY src/ ./src
RUN cargo chef prepare --recipe-path recipe.json

FROM chef AS builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY Cargo.toml Cargo.lock src/ ./
RUN cargo build --release

FROM docker.io/library/debian:trixie-slim AS runtime

LABEL org.opencontainers.image.title="rust based project template"
LABEL org.opencontainers.image.description="A simple rust based project template."
LABEL org.opencontainers.image.base.name="docker.io/library/debian:trixie-slim"

WORKDIR /app

COPY --from=builder /app/target/release/rust-based-project /usr/local/bin

ENTRYPOINT ["/usr/local/bin/rust-based-project"]
