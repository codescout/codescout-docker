# codescout-env

Docker-based environment for CodeScout

## Requirements

- Ubuntu 12.04
- Docker
- Vagrant (for local development)

## Environment

- Ruby 2.1
- Flog
- Rails Best Practices
- Rubocop
- Brakeman
- Sandi Meter
- Dependenci

## Installation

Make sure you have latest Vagrant installed. Clone repository and start VM:

```
vagrant up
```

After VM is started and provisioned, restart VM and connect via SSH:

```
vagrant reload
vagrant ssh
```

## Usage

```
make build   - Build image without cache and remove intermediate containers
make test    - Start a new shell session from built image
make tag     - Tag a new image for release
make release - Push image to docker index
make clean   - Remove image and all containers
```

## License

MIT License

Copyright (c) 2014 Doejo LLC
