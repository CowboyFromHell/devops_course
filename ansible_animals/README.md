# Ansible assignment
### Create the inventory file
Add hosts to **[webservers]** group in ```inventory_file``` in main directory and add vars for group.  
**Example:**
```
[webservers]
10.0.2.9
[webservers:vars]
ansible_become=yes ###Overrides the become directive, decides if privilege escalation is used or not.
ansible_become_method=sudo ####Which privilege escalation method should be used.
ansible_user=user ####The default ssh user name to use.
ansible_become_pass='{{ my_password }}' ###Set the privilege escalation password into the variable 'my_password'.
```
### Create password.yml 
Use ansible-vault to create password.yml:  
```ansible-vault create password.yml```

Add this line ```my_password: your_password``` into file


### Run playbook
Use this command:  
```ansible-playbook -i inventory_file --ask-vault-pass --extra-vars '@password.yml' deploy_site.yml```



### What can it?

```
curl -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' https://yourhost/
🐄 says moooo
🐄 says moooo
🐄 says moooo
Made with ❤️ by Antosha

curl -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' https://yourhost/
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
Made with ❤️ by Antosha
```

### About firewall
```rules.ipv4``` is file with settings for iptables firewall, it made possible to connection to ssh(22), http(80) and https(443) ports and block other connections.  
```restore_iptables.service``` is service restored rules iptables after reboot.