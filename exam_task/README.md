# Implementation of the CI/CD process

"What is it?" and "how is it used?" described in great detail in this **[article](https://www.redhat.com/en/topics/devops/what-is-ci-cd)**. To keep my README from being too big, I use a picture describing the CI / CD processes:
![ci_cd](/exam_task/pictures/ci_cd.png)
And below I will now describe how I see the release of this process using the example of two applications.


### This implementation uses:
+ **AWS cloud as cloud computing and data storage**
+ **Jenkins as the main tool for building, logging, delivering and deploying content**
+ **GitHub as code repository and version control**
+ **Snyk for security check**
+ **Docker for сontainerization**
+ **Docker Hub for storing custom app builders and custom jenkins image**
+ **Terraform for deployment "infrastructure as code"**
+ **Telegram messenger for notification of build states**

### Applications
I use two application:
+ **[Python application](https://github.com/CowboyFromHell/app_one)**
+ **[Golang application](https://github.com/CowboyFromHell/app_two)**

### Docker Hub
For future builds, I have prepared special builders for **[go](https://hub.docker.com/layers/159441296/privetkakdela/devops_course/go_builder/images/sha256-46e2588e18895400c81d42bb1138e77df1835ed3b3a5a93e4e47a58994c9a14e?context=repo)** and **[py](https://hub.docker.com/layers/159379567/privetkakdela/devops_course/python_builder/images/sha256-0e06bcb4775030a27d6893093a732bce05d1a28e6d5908b376fd93198009e0b3?context=repo)** applications. All libraries required for the build are installed in the builders.  
This makes the builders **standalone**. Also built **[jenkins](https://hub.docker.com/layers/159681876/privetkakdela/devops_course/jenk_aws_cli/images/sha256-52f9e9c5263e19f859df92c02fe4acb000bad7069274d545af921cf628cedac3?context=repo)** image with aws cli support. Source **[dockerfiles](https://github.com/CowboyFromHell/devops_course/tree/devops_master/exam_task/dockerfiles)**.


### Terraform
**Terraform** builds **AWS** infrastructure:
+ **VPC - virtual private cloud**
+ **Subnets - 3 public subnets in different availability zones**
+ **Security group - stateful firewall for EC2 instances**
+ **Network acl - stateless firewall for subnets**
+ **Internet gateway - gateway for VPC**
+ **Routes table - routes for subnets**
+ **S3 bucket - data storage**
+ **Endpoint - routes all S3 trafic**
+ **IAM role - assign a role to an EC2 instance from policy**
+ **Instances - EC2 virtual machines**

In the end, it launches the **ansible** **[playbook](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/source/deploy_docker_jenk.yml)** to deploy **jenkins settings** to the target host and rewrites the IPs on the **GitHub webhooks** with a script **[update_git_hook](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/source/update_git_hook)**.
In **[update_git_hook](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/source/update_git_hook)** I use **GitHub REST API** with my **token** for **GitHub**. Token encrypted with **openssl** and **aes-256-cbc** algorithm.

### Jenkins
**Jenkins** use pipelines for **[app_py](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/pipelines/pipeline_py)** and **[app_go](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/pipelines/pipeline_go)**. When building, **snyk** checks docker images for vulnerabilities, if found **snyk** stops building. Also after building apps starting trash collectors: **[remove_trash_py](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/pipelines/pipeline_trash_py_aws)**, **[remove_trash_go](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/pipelines/pipeline_trash_go_aws)**. All stages are reported in the **telegram**(**[py](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/pictures/py_tele.png)**, **[go](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/pictures/go_tele.png)**).  
If you need to restore a previous version, use **[pipeline_restore_go](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/pipelines/pipeline_restore_go)** and **[pipeline_restore_py](https://github.com/CowboyFromHell/devops_course/blob/devops_master/exam_task/pipelines/pipeline_restore_py)**.


![jenk_work](/exam_task/pictures/my_ci_cd.png)

# The final view of infrastructure:
![dip_work](/exam_task/pictures/Dip_inf.png)