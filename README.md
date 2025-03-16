# mihomo-dashboard
mihomo dashboard all in one

**自动定时更新**

[zashboard](https://github.com/Zephyruso/zashboard.git)

*端口 100 文件路径 /srv/zashboard*

[metacubexd](https://github.com/metacubex/metacubexd.git)

*端口 101 文件路径 /srv/metacubexd*

[Yacd](https://github.com/metacubex/Yacd-meta.git)

*端口 102 文件路径 /srv/yacd*

[Razord](https://github.com/metacubex/Razord-meta.git)

*端口 103 文件路径 /srv/razord*

**部署**

```bash
docker run -d \
    --name mihomo-dashboard \
    -p 1100:100 \
    -p 1101:101 \
    -p 1102:102 \
    -p 1103:103 \
    mihomo-dashboard
```
