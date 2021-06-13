# Shows connections
This BASH script shows the connections of your processes!!!  
Run the script ```bash bash_task``` or ```bash bash_task PID or NAME_OF_PROCESS``` and answer questions

### Example of a running script:
````
Name process or PID (default all): 
Connection types:
1) LISTEN
2) ESTABLISHED
3) TIME_WAIT
4) CLOSE_WAIT
5) ALL
Enter the number from 1 to 5 (default 5): 2
Do you want run from sudo user?
You need superuser (root) privileges to see all the information.
Yes/No (default no): yes
Enter the number of lines for output (default all of 31 connections): 3

City: Cambridge;Amsterdam;
Organization: Akamai Technologies, Inc. (AKAMAI);Akamai International, BV (AIB-17);  (Process: 33144/firefox; IP: 104.75.51.171; Count: 2; State: ESTABLISHED)

City: No city
No organization  (Process: 33144/firefox; IP: 77.88.21.119; Count: 1; State: ESTABLISHED)

City: Mountain View;
Organization: Google LLC (GOGL);  (Process: 33144/firefox; IP: 74.125.131.94; Count: 1; State: ESTABLISHED)
````
**Be aware that an ip address sometimes has several names.**  
**Example:**  
```
City: Cambridge;Amsterdam;
Organization: Akamai Technologies, Inc. (AKAMAI);Akamai International, BV (AIB-17);  (Process: 33144/firefox; IP: 104.75.51.171; Count: 2; State: ESTABLISHED)
```