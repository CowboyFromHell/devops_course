# Ansible assignment
### Create the inventory file
Add hosts to [webservers] group in /etc/ansible/hosts and add vars for group
Example:
```
[webservers]
10.0.2.9
[webservers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_user=user
ansible_become_pass='{{ my_password }}'
```
### Create password.yml 
Use ansible-vault to create password.yml:
```ansible-vault create password.yml```

And add this line ```my_sudo_pass: my_password``` into file


### Run playbook
Run command:
```ansible-playbook  --ask-vault-pass --extra-vars '@password.yml' deploy_site.yml```



### What can it?

```
curl -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' http://yourhost/ or https://yourhost/
🐄 says moooo
🐄 says moooo
🐄 says moooo
Made with ❤️ by Antosha

curl -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' http://yourhost/ or https://yourhost/
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
🐘 says whoooaaa
Made with ❤️ by Antosha
```