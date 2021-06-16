# Shows connections
This BASH script shows the connections of your processes!!!  
Run this script ```bash bash_task``` or ```bash bash_task PID or NAME_OF_PROCESS``` and answer questions

### Example of the running script:
````
Name process or PID (default all): firefox
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
Enter the number from 1 to 13 (default 13): 
Do you want run from sudo user?
You need superuser (root) privileges to see all the information.
Yes/No (default no): yes
Enter the number of lines for output (default all of 14 connections): 4

City: San Francisco;
Organization: Fastly (SKYCA-3);  (Process: 33144/firefox; IP: 151.101.246.83; Count: 2; State: ESTABLISHED)

City: No city
No organization  (Process: 33144/firefox; IP: 80.239.201.60; Count: 1; State: ESTABLISHED)

City: No city
No organization  (Process: 33144/firefox; IP: 77.88.21.119; Count: 1; State: ESTABLISHED)

City: Ashburn;
Organization: MCI Communications Services, Inc. d/b/a Verizon Business (MCICS);  (Process: 33144/firefox; IP: 68.232.34.11; Count: 1; State: ESTABLISHED)
````
**Be aware that an ip address sometimes has several names.**  
**Example:**  
```
City: Cambridge;Amsterdam;
Organization: Akamai Technologies, Inc. (AKAMAI);Akamai International, BV (AIB-17);  (Process: 33144/firefox; IP: 104.75.51.171; Count: 2; State: ESTABLISHED)
```