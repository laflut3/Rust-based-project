# Rust Template Project

Base template for a Rust service with CI, container build, release workflow, and security scanning.

## Template Checklist

When you create a new repository from this template, update the items below before the first merge.

### 1) Project identity

- [ ] Update `README.md` title/description.
- [ ] Update `Cargo.toml`:
  - [ ] `[package].name`
  - [ ] `version`
  - [ ] `description`
  - [ ] `repository`, `homepage`, `documentation` (if used)
  - [ ] `license`
- [ ] Update `Cargo.lock` by running `cargo check` after metadata changes.
- [ ] Rename crate references in tests if the binary name changed (`env!("CARGO_BIN_EXE_<name>")`).

### 2) Application code

- [ ] Replace template output/logic in `src/main.rs`.
- [ ] Update or replace template tests in `tests/`.
- [ ] Ensure app port and runtime behavior match your service contract.

### 3) Container image

- [ ] Update binary name in `Dockerfile`:
  - [ ] `cp .../release/<binary-name> /app/<binary-name>`
  - [ ] `COPY --from=builder /app/<binary-name> /usr/local/bin/<binary-name>`
  - [ ] `ENTRYPOINT ["/usr/local/bin/<binary-name>"]`
- [ ] Update OCI labels in `Dockerfile`:
  - [ ] `org.opencontainers.image.title`
  - [ ] `org.opencontainers.image.description`
  - [ ] any additional labels you require
- [ ] Keep image names lowercase (Docker/OCI requirement).

### 4) GitHub Actions and release

- [ ] Update container repository slug in workflows:
  - [ ] `.github/workflows/build.yml`
  - [ ] `.github/workflows/release.yml`
  - Use `ghcr.io/<owner>/<repo>` in lowercase.
- [ ] Review workflow triggers (`push`, `pull_request`, tags) for your branching strategy.
- [ ] Review pinned action versions and toolchain versions (Rust, Python, Docker actions).
- [ ] If release tags differ from `v*`, update `.github/workflows/release.yml`.
- [ ] Verify required GitHub permissions for workflows (`contents`, `packages`, `security-events`).

### 5) Security and compliance

- [ ] Update `SECURITY.md` with real disclosure contacts and SLA.
- [ ] Review `trivy.yaml` and `.trivyignore` for your risk policy.
- [ ] Review `LICENSE` and attribution requirements.

### 6) Local developer workflow

- [ ] Install hooks:
  ```sh
  uv tool install pre-commit
  pre-commit install
  ```
- [ ] Run checks before first push:
  ```sh
  pre-commit run --all-files
  cargo test
  ```
- [ ] Add `.env`/`.env.example` only if your app actually uses environment variables.
