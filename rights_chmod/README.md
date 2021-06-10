# How to get the execution rights back to chmod 
### Run as root user:
**x32 system:**
+ ```/lib/ld-linux.so /bin/chmod +x /bin/chmod```

**x64 system:**
+ ```/lib64/ld-linux-x86-64.so.2 /bin/chmod +x /bin/chmod```

**Alternative way:**
+ ```busybox chmod +x /bin/chmod```