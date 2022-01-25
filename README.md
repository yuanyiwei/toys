# toys

一些玩具，放一些小到不适合单独开仓库的代码和项目。

- `auto-wlt`: [科带网络通](http://wlt.ustc.edu.cn/)断网重连脚本。
- `tmux-run`: 一个 `run_gost.sh` 的小样例脚本，可以定义 tmux 窗口的 session、title 等信息。
- `tr-auto-refresh`: transmission 自动刷新 tracker，参照 <https://yqf3139.github.io/2016/09/10/find-more-transmission-peers-to-boost-seeding-speed-automaticly/>，加入了 Auth 头，是 user:pass 的 base64。
- `debian-init`: 买了很多月抛机器，init 到手累了，写了个初始化脚本。
- `vps-backup`: 不稳定的月抛机器需要备份，利用 rclone 每天备份数据到科带 A1 (或其他授权) O365 账号的 1drv 中，计时器用 crontab 或者 systemd.timer 均可。
- `chn-ip`: 获取中国 IP 地址，自用。
- `stat`: 从 MobaXterm 里找出来的获取资源占用的脚本，无需 Root，关于 MobaXterm 本地怎么处理还没看，netstat 处理有点问题。

_Deprecated_:

- `sub`: ~~手动订阅，自用。原因是之前在 Qv2ray 变 Archive 后和 myl 聊到订阅解析的问题，想手动写个轮子。~~有点奇怪，不用了。
- `clashr-for-linux` : 在 Linux 上管理 clash 订阅（那时 clash 核心还不支持 SSR、linux 上也没有 [juewuy/ShellClash](https://github.com/juewuy/ShellClash)、[Fndroid/clash_for_windows_pkg](https://github.com/Fndroid/clash_for_windows_pkg) 这种先进的客户端），现在都有 Clash for Windows for Linux 了 QaQ。
- `autojs` : 一些 auto.js 驱动的脚本。
- `pdf-catalog`: 结合 <https://github.com/ifnoelse/pdf-bookmark> 项目，用 Python 正则和 OCR 识别给没有目录的 PDF 加上目录，里面是第三版龙书的样例。
- `tqm-ping`: [科带教学质量管理平台](https://tqm.ustc.edu.cn/)的油猴一键评价脚本。（已经没法用了，大四了也用不到了）
- `python-proxy`: 学习 FSM。

## donation

开了个爱发电：<https://afdian.net/@Totoro/plan>，手续费 6%（~~不会有人给我送钱吧，不会吧不会吧~~
