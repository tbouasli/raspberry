# GitHub Actions Workflows

This directory contains a single GitHub Actions workflow for automatically building and pushing Docker images for the services in this repository.

## Workflow

- **`build-services.yml`** - Builds and pushes Docker images for all services
  - Uses path-based triggers to only run when service files change
  - Supports manual dispatch with service selection
  - Triggers on push/PR to main/master branches

## Setup Requirements

### Docker Hub Credentials

You need to set up the following secrets in your GitHub repository:

1. Go to your repository settings
2. Navigate to "Secrets and variables" → "Actions"
3. Add the following repository secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub password or access token

### Docker Hub Access Token (Recommended)

Instead of using your Docker Hub password, it's recommended to create an access token:

1. Go to Docker Hub → Account Settings → Security
2. Create a new access token with "Read, Write, Delete" permissions
3. Use this token as `DOCKER_PASSWORD` in your GitHub secrets

## Workflow Features

### Multi-Architecture Support
All workflows build images for both `linux/amd64` and `linux/arm64` architectures.

### Caching
- Uses GitHub Actions cache for Docker layer caching
- Significantly reduces build times for subsequent runs

### Security Scanning
The `build-with-security.yml` workflow includes:
- Trivy vulnerability scanning
- Results uploaded to GitHub Security tab
- Daily scheduled scans

### Tagging Strategy
Images are tagged with:
- `latest` for the default branch
- Branch name for feature branches
- SHA-based tags for specific commits
- Version tags for releases (e.g., `v1.0.0`)

## Usage

### Automatic Builds
- Push changes to trigger builds automatically
- Only services with changed files will be built (intelligent change detection)
- No redundant builds - each service builds only once per change

### Manual Builds
- Use the "Actions" tab in GitHub to manually trigger workflows
- Select `build-services.yml` and choose which services to build

### Creating Releases
The workflow automatically tags images with the latest commit SHA and branch name. For versioned releases, you can manually tag your Docker images after they're built.

## Image Names

The workflow builds and pushes images to Docker Hub with the following names:
- `thomasbouasli/noip-duc`
- `thomasbouasli/minecraft` 
- `thomasbouasli/nginx`

## Monitoring

- Check the "Actions" tab in GitHub to monitor workflow runs
- Security scan results are available in the "Security" tab
- Failed builds will send notifications based on your GitHub notification settings
