# Tracing logs with [GoAccess](https://goaccess.io/)

This repo is not to teach you how to use GoAccess in detail.
It is here to keep my log-tracing tools and patterns in one place.

## Patterns

- AWS ALB
- Nginx official docker

## Dependencies

- [rg](https://github.com/BurntSushi/ripgrep) to cleanup access/error logs
- [GoAccess](https://goaccess.io/)

## How to parse logs

- Get your logs somehow in one file `logs/access.log`
- Pipe logs into `cat access.log | make nginx`
- look at `pages/acccess.html`

## Working with docker


Get all pods `kubectl get pods --no-headers=true -n <your-namespace>  | cut -d" " -f1 > pods.txt`

Combine all logs `cat pods.txt | while read l; do $(kubectl logs -n <your-namespace>  $l -c nginx >> logs/access.log&); done`