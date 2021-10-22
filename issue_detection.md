### Port Scanning(nmap)
On Console:

    ...
    tlssrv: auth_proxy: auth_proxy write fd: Hangup
    tlssrv: auth_proxy: auth_proxy write fd: Hangup

### Password Guessing:
In /sys/log/auth:

    ...
    authserve Oct 21 20:26:10 tr-ok glenda@glenda(192.168.9.1) -> glenda@glenda
    authserve Oct 21 20:26:18 tr-ok glenda@glenda(192.168.9.1) -> glenda@glenda
    authserve Oct 21 20:26:24 tr-ok glenda@glenda(192.168.9.1) -> glenda@glenda
    authserve Oct 21 20:26:34 tr-ok glenda@glenda(192.168.9.1) -> glenda@glenda
    authserve Oct 21 20:26:38 tr-ok glenda@glenda(192.168.9.1) -> glenda@glenda
    authserve Oct 21 20:26:41 tr-ok glenda@glenda(192.168.9.1) -> glenda@glenda

A bunch of connection attemps from the same IP address. Auth log doesnt say if it was successful

### Credential Stuffing
In /sys/log/auth:

    ...
    authserve Oct 21 20:23:51 pak-fail no AES key for id bob
    authserve Oct 21 20:23:52 tr-ok bob@bob(192.168.9.1) -> bob@glenda
    authserve Oct 21 20:23:58 pak-fail no AES key for id bill
    authserve Oct 21 20:23:59 tr-ok bill@bill(192.168.9.1) -> bill@glenda
    authserve Oct 21 20:24:06 pak-fail no AES key for id betty
    authserve Oct 21 20:24:07 tr-ok betty@betty(192.168.9.1) -> betty@glenda

A bunch of failed auths for users that dont exist. Coming from one IP address.
