**Network Identification and Enumeration**<br />
Plan 9 is a Grid Operating System. As with many things, what it looks like depends on its use. Below is what these servers might look like when doing an nmap with service/version detection.

**File Server**<br />

    PORT      STATE SERVICE VERSION
    564/tcp   open  9pfs?
    
Note, if you see an open File Server, you might be able to read (and write to) the filesystem with the "none" user.

**Auth Server**<br />

    PORT      STATE SERVICE     VERSION
    567/tcp   open  banyan-rpc?

**CPU Server**<br />

    PORT      STATE SERVICE VERSION
    17019/tcp open  unknown
    17020/tcp open  unknown

**PXE Server**<br />

    PORT   STATE         SERVICE VERSION
    69/udp open          tftp    Plan 9 tftpd

**Web Server**<br />

    PORT   STATE SERVICE VERSION
    80/tcp open  http    rc-httpd
