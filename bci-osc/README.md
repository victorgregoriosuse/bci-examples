# SLE BCI container with OSC

- https://registry.suse.com/
- https://en.opensuse.org/openSUSE:OSC


# Build

```
docker buildx build -t sle-osc -f Containerfile .
```

#  Run

```
docker run -it sle-osc
```