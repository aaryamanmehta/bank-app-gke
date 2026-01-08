Deployment and image publishing notes


1) (Optional) Create Artifact Registry repo (one-time). You already created `bank-artifacts` in `us-east1`.

```bash
./scripts/create_artifact_repo.sh
```

2) Build and push images (frontend uses nonstandard Dockerfile name):

```bash
./scripts/build_and_push_images.sh
```

This builds:
- backend -> `us-east1-docker.pkg.dev/bank-app-gke/bank-artifacts/bank-backend:latest`
- frontend -> `us-east1-docker.pkg.dev/bank-app-gke/bank-artifacts/bank-frontend:latest`

3) Apply Kubernetes manifests:

```bash
kubectl apply -f bank-api-gke/backend.yaml
kubectl apply -f bank-web-gke/frontend.yaml
```

4) Create GitHub repo and push (requires `gh`):

```bash
./scripts/create_github_repo.sh
```
