Run container
---
```
$ podman run -d --name llm --privileged --security-opt="seccomp=unconfined" \
  -p 8443:8443 localhost/llm-proxy:latest
```

Deploy container as systemd service
---
```
# cd /etc/systemd/system
# podman generate systemd --files --name llm
# systemctl enable container-llm.service
# systemctl start container-llm.service
# systemctl status container-llm.service
```