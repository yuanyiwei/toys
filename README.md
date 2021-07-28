# toys

一些玩具，放一些小到不适合单独开仓库的代码和项目

（注意 commit 日期，多半已废弃，用来记录）

- `clashr-for-linux`: 在 Linux 上管理 clash 订阅（那时 clash 核心还不支持 SSR、linux 上也没有 [juewuy/ShellClash](https://github.com/juewuy/ShellClash)、[Fndroid/clash_for_windows_pkg](https://github.com/Fndroid/clash_for_windows_pkg) 这种先进的客户端）
- `autojs`: 一些 auto.js 驱动的脚本
- `tqm-ping`: [USTC 教学质量管理平台](https://tqm.ustc.edu.cn/)的油猴一键评价脚本
- `auto-wlt`: [网络通](http://wlt.ustc.edu.cn/)断网重连脚本
- `tmux-run`: 一个 `run_gost.sh` 的小样例脚本，可以定义 tmux 窗口的 session、title 等信息
- `rclone-backup`: 利用 A1 (或其他授权) O365 账号的 1drv 备份服务器数据（本来从 alpine 写了一个，结果发现 rclone 官方就维护了一个镜像），放 crontab 或者 systemd.timer 里均可
