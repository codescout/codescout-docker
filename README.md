# codescout-env

Docker-based environment for CodeScout

## Requirements

- Ubuntu 12.04
- Docker
- Vagrant (for local development)

## Installation

Make sure you have latest Vagrant installed. Clone repository and start VM:

```
vagrant up
```

After VM is started and provisioned, connect via SSH:

```
vagrant ssh
```

## Build Image

Execute the following steps to build a new Docker image:

```
cd /dockerfiles
docker builds -t codescout .
```

## License

MIT License

Copyright (c) 2014 Doejo LLC