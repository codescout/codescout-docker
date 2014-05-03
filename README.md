# codecheck

Docker-based environment with Ruby code analysis tools

## Requirements

- Ubuntu 12.04
- Docker
- Vagrant

## Installation

Make sure you have latest Vagrant installed. Clone repository and start VM:

```
vagrant up
```

VM will be automatically provisioned. Takes just a few minutes.

Connect to VM and switch to /codecheck directory:

```
vagrant ssh
cd /codecheck
```

Build docker images for code checks:

```
./build.sh
```

This could take up to 10-15 minutes

## Usage

Run code check for a public repo:

```
./run https://github.com/discourse/discourse
```

More to come