# Ubuntu 24.04 for Render

## Deploy with Blueprint

Create a new GitHub repository and upload this project.

In Render:

```text
New
Blueprint
Connect repository
Apply
```

Render reads `render.yaml` and builds the Dockerfile.

## Manual deployment

Use:

```text
Service type: Web Service
Runtime: Docker
Dockerfile path: ./Dockerfile
Health check path: /health
```

## Pages

```text
/
```

Choose Desktop or Terminal.

```text
/desktop
```

Ubuntu desktop through noVNC.

```text
/terminal
```

Ubuntu terminal through ttyd.

## Terminal login

```text
Username: ubuntu
Password: ubuntu
```

The terminal starts in:

```text
/home/ubuntu
```

The free Render service can sleep when idle and restart with an empty filesystem.
