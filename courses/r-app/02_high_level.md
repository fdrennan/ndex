## Replication

### Setup Domain on AWS

1.  Register Domain with Route53
2.  Create EC2 Server
3.  Elastic IP
4.  Register IP with Route53
5.  Get pem key

### EC2 Config

1.  On EC2 t2.nano, Ubuntu, install nginx.
2.  Apply [nginx.conf](https://github.com/fdrennan/ndex/blob/main/nginx.conf/nginx/nginx.conf) and restart

### Local Config

1.  [`docker-compose.yaml`](https://github.com/fdrennan/ndex/blob/main/docker-compose.yaml) front load with [nginx.conf](https://github.com/fdrennan/ndex/blob/main/nginx/nginx.conf)

2.  Build [`ndex`](https://github.com/fdrennan/ndex/blob/main/DESCRIPTION) with run `make db restart` from [`Makefile`](https://github.com/fdrennan/ndex/blob/main/Makefile)

3.  Build [`./backend`](https://github.com/fdrennan/ndex/blob/main/backend/DESCRIPTION)

    -   `cd backend` and then `make db restart`

4.  run `make as` from `Makefile` to create autossh connection between local laptop and ec2 server

### Development Installation

1.  Set up `ndex` in `./.` run `devtools::install_deps()`
2.  Set up `backend` in `./backend/` run `devtools::install_deps()`
3.  R
4.  RStudio
5.  PyCharm

## TOC
