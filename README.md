# Kali (Rolling) Ansible Test Image #

Kali (Rolling) Docker container for Ansible playbook and role testing.

## How to Build ##

If you need to build the image on your own locally, do the following:

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. `cd` into this directory.
  3. Run `docker build -t docker-kali-ansible .`

## How to Use ##

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. Pull this image from Docker Hub: `docker pull cisagov/docker-debian10-ansible:latest` (or use the image you built earlier).
  3. Run a container from the image: `docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro cisagov/docker-debian10-ansible:latest`.
  4. Use Ansible inside the container:
    a. `docker exec --tty [container_id] env TERM=xterm ansible --version`
    b. `docker exec --tty [container_id] env TERM=xterm ansible-playbook /path/to/ansible/playbook.yml --syntax-check`

## Author Information ##

Shane Frasier - <jeremy.frasier@trio.dhs.gov>

Heavily based on geerlingguy/docker-debian10-ansible by [Jeff
Geerling](https://www.jeffgeerling.com/) AKA @geerlingguy.
