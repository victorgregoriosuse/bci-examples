# SLE BCI container with SSHD

- https://registry.suse.com/

# Instructions

## Build

You must set a password for at build time through a build argument.

```bash
docker buildx build -t bci-sshd --build-arg PASSWD=<SET_A_PASSWORD_HERE> -f Containerfile .
```

## Run

```bash
docker compose up -d 
ssh localhost -p 1122 -l root
```

## Shutdown
```
docker compose down
```
