# toys

一些玩具，放一些小到不适合单独开仓库的代码和项目

用的时候请注意 commit 日期，小心已废弃、用来记录的项目

- `clashr-for-linux`: 在 Linux 上管理 clash 订阅（那时 clash 核心还不支持 SSR、linux 上也没有 [juewuy/ShellClash](https://github.com/juewuy/ShellClash)、[Fndroid/clash_for_windows_pkg](https://github.com/Fndroid/clash_for_windows_pkg) 这种先进的客户端）
- `autojs`: 一些 auto.js 驱动的脚本
- `tqm-ping`: [USTC 教学质量管理平台](https://tqm.ustc.edu.cn/)的油猴一键评价脚本
- `auto-wlt`: [网络通](http://wlt.ustc.edu.cn/)断网重连脚本
- `tmux-run`: 一个 `run_gost.sh` 的小样例脚本，可以定义 tmux 窗口的 session、title 等信息
- `tr-auto-refresh`: transmission 自动刷新 tracker，参照 <https://yqf3139.github.io/2016/09/10/find-more-transmission-peers-to-boost-seeding-speed-automaticly/>，加入了 Auth 头，是 user:pass 的 base64
- `debian-init`: 买了很多月抛机器，init 到手累了，写了个个人喜好的初始化脚本
- `vps-backup`: 同上，买了很多不稳定的月抛机器，利用 rclone 每天备份目录，利用 A1 (或其他授权) O365 账号的 1drv 备份数据，计时器用 crontab 或者 systemd.timer 均可
