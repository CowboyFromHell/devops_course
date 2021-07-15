# Shows connections
This BASH script shows the connections of your processes!!!  
Run this script ```bash bash_script``` or ```bash bash_script PID or NAME_OF_PROCESS``` and answer questions

### Example of the running script:

**netstat:**
```
Network tool for use ss/netstat (default netstat): 
Network tool: netstat
Process name or PID (default all): 
Connection types:
1 - ESTABLISHED
2 - SYN_SENT
3 - SYN_RECV
4 - FIN_WAIT1
5 - FIN_WAIT2
6 - TIME_WAIT
7 - CLOSE
8 - CLOSE_WAIT
9 - LAST_ACK
10 - LISTEN
11 - CLOSING
12 - UNKNOWN
13 - ALL
Enter the number from 1 to 13 (default 13): 1
Do you want run from sudo user?
You need superuser (root) privileges to see all the information.
Yes/No (default no): yes
Enter the number of lines for output (default all of 2 connections): 

City: Seattle;
Organization: Amazon Technologies Inc. (AT-88-Z);  (Process: 43295/firefox; IP: 52.41.2.143; Count: 1; State: ESTABLISHED)

City: Los Angeles;
Organization: Internet Assigned Numbers Authority (IANA);  (Process: 542/NetworkManager; IP: 10.0.2.3; Count: 1; State: ESTABLISHED)

```

**ss:**
````
Network tool for use ss/netstat (default netstat): ss
Network tool: ss
Process name or PID (default all): 
Connection types:
1 - established
2 - syn-sent
3 - syn-recv
4 - fin-wait-1
5 - fin-wait-2
6 - time-wait
7 - closed
8 - close-wait
9 - last-ack
10 - listening
11 - closing
12 - all
Enter the number from 1 to 12 (default 12): 1
Do you want run from sudo user?
You need superuser (root) privileges to see all the information.
Yes/No (default no): yes
Enter the number of lines for output (default all of 2 connections): 

City: Seattle;
Organization: Amazon Technologies Inc. (AT-88-Z);  (Process: users:(("firefox",pid=43295,fd=130)); IP: 52.41.2.143; Count: 1; State: established)

City: Los Angeles;
Organization: Internet Assigned Numbers Authority (IANA);  (Process: users:(("NetworkManager",pid=542,fd=23)); IP: 10.0.2.3; Count: 1; State: established)
````


**Be aware that an ip address sometimes has several names.**  
**Example:**  
```
City: Cambridge;Amsterdam;
Organization: Akamai Technologies, Inc. (AKAMAI);Akamai International, BV (AIB-17);  (Process: 33144/firefox; IP: 104.75.51.171; Count: 2; State: ESTABLISHED)
```