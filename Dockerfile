FROM lukemathwalker/cargo-chef:0.1.77-rust-1.95@sha256:00c3c07c51d092325df88f0df2d626cd4302e12933f179ba154509cc314d6c2a AS chef
WORKDIR /app

FROM chef AS planner
COPY Cargo.toml Cargo.lock ./
COPY apps/backend/Cargo.toml ./apps/backend/Cargo.toml
COPY apps/backend/src/ ./apps/backend/src
RUN cargo chef prepare --recipe-path recipe.json

FROM chef AS builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY Cargo.toml Cargo.lock ./
COPY apps/backend/ ./apps/backend
RUN cargo build --release --package leto

FROM docker.io/library/debian:trixie-slim@sha256:cedb1ef40439206b673ee8b33a46a03a0c9fa90bf3732f54704f99cb061d2c5a AS runtime

LABEL org.opencontainers.image.title="leto backend"
LABEL org.opencontainers.image.description="Rust backend for leto."
LABEL org.opencontainers.image.base.name="docker.io/library/debian:trixie-slim"

WORKDIR /app

COPY --from=builder /app/target/release/leto /usr/local/bin

ENTRYPOINT ["/usr/local/bin/leto"]
