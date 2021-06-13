# Shows connections
This BASH script shows the connections of your processes!!!  
Run the script ```bash bash_task``` and answer questions.  

**Be aware that an ip address sometimes has several names.**  
**Example:**  
```
Amazon.com, Inc. (AMAZO-4)
Amazon.com, Inc. (AMAZON-4)  (Process: 6062/firefox; IP: 65.9.53.76; Count: 1; State: ESTABLISHED)
```

### Example of a running script:
````
Name process or PID (default all): 
Connection types:
1) LISTEN
2) ESTABLISHED
3) TIME_WAIT
4) CLOSE_WAIT
5) ALL
Enter the number from 1 to 5 (default 5): 
Do you want run from sudo user?
You need superuser (root) privileges to see all the information.
Yes/No (default no): yes
[sudo] password for antosha:
Enter the number of lines for output (default all of 6 connections): 3
   DigitalOcean, LLC (DO-13)  (Process: 27539/plugin_host-3; IP: 45.55.41.223; Count: 1; State: CLOSE_WAIT)
   Internet Assigned Numbers Authority (IANA)  (Process: 29322/sshd; IP: 192.168.1.42; Count: 1; State: ESTABLISHED)
   Internet Assigned Numbers Authority (IANA)  (Process: 603/NetworkManager; IP: 192.168.1.1; Count: 1; State: ESTABLISHED)
````
