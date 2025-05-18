Run container
---
```
$ podman run -d --name llm --privileged --security-opt="seccomp=unconfined" \
  -v /etc/letsencrypt/archive/acme.com:/cert:ro \
  -p 443:8443 localhost/llm-proxy:latest
```

Deploy container as systemd service
---
```
# cd /etc/systemd/system
# podman generate systemd --files --name llm
# systemctl daemon-reload
# systemctl enable container-llm.service
# systemctl start container-llm.service
# systemctl status container-llm.service
```