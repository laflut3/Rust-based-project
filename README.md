# leto

Monorepo template with:

- a Rust backend in `apps/backend`
- a future React frontend in `apps/frontend`

## Repository layout

```txt
.
├── apps
│   ├── backend   # Rust binary crate
│   └── frontend  # React app placeholder
├── Cargo.toml    # Workspace manifest
└── Dockerfile    # Backend container image
```

## Development

### Backend (Rust)

Run the backend:

```sh
cargo run -p leto
```

Run backend tests:

```sh
cargo test -p leto
```

### Frontend (React, planned)

`apps/frontend` is prepared to host the React app.

When you are ready to bootstrap it, run a scaffold command from `apps/frontend` (for example with Vite), then connect it to your backend API.

### Pre-commit

```sh
uv tool install pre-commit
pre-commit install
pre-commit run --all-files
```

## Template changes

When creating a new repository from this template, complete this checklist before the first merge:

- [ ] Rename the backend crate in `apps/backend/Cargo.toml` (`[package].name`) and adjust `version` if needed.
- [ ] Update the binary name in `Dockerfile`:
  - [ ] `COPY --from=builder /app/target/release/<binary-name> /usr/local/bin`
  - [ ] `ENTRYPOINT ["/usr/local/bin/<binary-name>"]`
- [ ] Update OCI labels in `Dockerfile` (`title`, `description`) to match the new project.
- [ ] Update the image tag in `.github/workflows/build.yml` (replace `laflut3/leto` with `<owner>/<repo>`).
- [ ] Update the `README.md` title and project description.
- [ ] Update `SECURITY.md` with the real vulnerability disclosure process (contact details, response times).
- [ ] Review CI tool versions in `.github/workflows/*.yml` (Rust, Python, action versions).
- [ ] Configure required CI secrets/settings if you publish container images (registry/package permissions).
- [ ] Review `LICENSE` and attribution if the new project requires a different setup.
- [ ] Create and document a `.env` file (or `.env.example`) if the application depends on environment variables.
- [ ] Run quality checks and tests locally before the first push:
  - [ ] `pre-commit run --all-files`
  - [ ] `cargo test -p <backend-crate-name>`
