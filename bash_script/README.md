# Shows connections
This BASH script shows connecting your process!!!  
Run the script ```bash bash_task``` and answer about questions.  
If there are names without ip, then they are aliases for the same ip:  
```
Amazon.com, Inc. (AMAZO-4)
Amazon.com, Inc. (AMAZON-4)  (Process: 6062/firefox; IP: 65.9.53.76; Count: 1; State: ESTABLISHED)
```

### Example:
````
Name process or PID (default all): 6062
Connection types:
1) LISTEN
2) ESTABLISHED
3) TIME_WAIT
4) CLOSE_WAIT
5) ALL
Enter number from 1 to 5 (default 5): 2
Do you want run from sudo user?
You need superuser (root) privileges to see all the information.
Yes/No (default no): yes
Number of lines for output (default all): 6
   No organization  (Process: 6062/firefox; IP: 93.184.220.29; Count: 2; State: ESTABLISHED)
   No organization  (Process: 6062/firefox; IP: 91.228.74.134; Count: 1; State: ESTABLISHED)
   Amazon.com, Inc. (AMAZO-4)
   Amazon.com, Inc. (AMAZON-4)  (Process: 6062/firefox; IP: 65.9.53.76; Count: 1; State: ESTABLISHED)
   Amazon.com, Inc. (AMAZO-4)
   Amazon.com, Inc. (AMAZON-4)  (Process: 6062/firefox; IP: 65.9.53.128; Count: 1; State: ESTABLISHED)
   Google LLC (GOGL)  (Process: 6062/firefox; IP: 64.233.162.155; Count: 1; State: ESTABLISHED)
   Amazon Technologies Inc. (AT-88-Z)  (Process: 6062/firefox; IP: 34.217.188.66; Count: 1; State: ESTABLISHED)
````