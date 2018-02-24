# Configuration Management And Build


## Team Members

| Name | Unity Id |
| --- | --- |
| Rishi Jain | rjain9 |
| Omkar Acharya | oachary |
| Shriyansh Yadav | scyadav |
| Urmil Parikh | uparikh |

## Architecture Diagram

<img src="https://github.ncsu.edu/rjain9/CSC519DevOps-Project/blob/ConfigAndBuild/images/Architecture.png" width="1000"> 

## Directory Structure

<img src="https://github.ncsu.edu/rjain9/CSC519DevOps-Project/blob/ConfigAndBuild/images/DirectoryStructure.png"> 

## Tasks and Challenges:

### Set Environment Variables:  

For executing the files, initially the following environment variables need to be setup:  
  ```
    1.  AWS_KEY_PAIR
    2.  AWS_ACCESS_KEY
    3.  AWS_SECRET_KEY
    4.  GITHUB_USERNAME
    5.  GITHUB_PASSWORD
    6.  MONGO_PORT
    7.  MONGO_IP
    8.  MONGO_USER
    9.  MONGO_PASSWORD
   10.  MAIL_USER
   11.  MAIL_PASSWORD
   12.  MAIL_SMTP
  ```  

### Provisioning AWS servers:  
  
  We have provisioned 3 AWS servers: A Jenkins Server and 2 application servers for checkbox.io and iTrust. The server setup 
  was automated using Ansible. For the Jenkins server, we have also installed certain plugins: git, maven-plugin, nodejs, 
  postbuild-task,  envinject. 
  
  After the successful run of build jobs, the post-build jobs create two AWS application servers for checkbox.io and iTrust.
  
* **Challenges:**  
  The major challenge while automating Jenkins server setup, was to avoid the 'Jenkins setup page'. Later, it was overcome by
  adding wait for Jenkins to start and later, disabling the setup wizard by making the following changes to the config file:
  
    ```
    <useSecurity>true</useSecurity>
    <authorizationStrategy class="hudson.security.AuthorizationStrategy$Unsecured"/>
    <securityRealm class="hudson.security.SecurityRealm$None"/>
    ```

### Build Jobs:   
  
  Our final goal is to setup two different applications on different VMs- 
  * checkbox.io  
  * iTrust  
    
  **Challenges:**
  The documentation and resources for Jenkins-job-builder were limited and hence a good amount of time was spent in
  learning how to build jobs using it.
  The build jobs for each of the applications were as follows:
  
  * **checkbox.io:**
    ```
    npm install
    ```
    
  * **iTrust:**
    ```
    mvn clean test verify checkstyle:checkstyle
    ```

### Post-build Jobs:

  * checkbox.io:
    
    * **Challenges:**
      
      For nginx setup, we had to make certain changes in the config and defaults file. We weren't aware of copying the 
      config files to  the new location for it to run on the web server.  
      For Mongo DB, we had to make sure the mongodb admin user is created with proper roles, to avoid any access issues.
    
  * iTrust:
    
    * **Challenges:**
      
      For MySQL DB, we encountered 'Access Denied for root@localhost' multiple times. Later, to overcome it, we understood
      we had to copy some files (hibernate.properties and db.properties) to proper location and we had to add skip-grant-
      tables in my.cnf for connection the application to mysql.
      Thus, MySQL was configured properly. 
      
  * Both the post build jobs consisted of:
      * Installing dependencies
      * Cloning the iTrust repo and configuring
      * Running the app

### Contributions:

* Rishi Jain (rjain9)
  * Manually setting up Jenkins and building jobs for checkbox.io and iTrust to evaluate dependencies and plugins. 
  * Manually checkbox.io, iTrust to evaluate the dependencies and identifying the tasks.
  * Developed scripts for post build action for checkbox.io and iTrust and tested them initially on Vagrant and later testing and resolving issues for succesfully running them on AWS-EC2.
  * Worked on setting up environment variables on Jenkins Server and Production Servers(checkbox.io and iTrust).
  * Integrated build and post build tasks.
  * Created Readme and Screencast.
* Omkar Acharya (oachary)
* Shriyansh Yadav (scyadav):
  * Worked on the post-build script for iTrust.
  * Worked on dealing with the mongodb issue and initial post-build job for checkbox.io
  * Started with the creation of build-jobs using jenkins-job-builder
* Urmil Parikh (uparikh): 
  * Wrote basic script for iTrust. Tested it manually on vagrant machine.
  * Solved issues with iTrust deployment on ec2 instance by changing mysql config file.
  * Solved issues with envinject on jenkins server.
  * Created task for SSH key assigning for remote provisioning in post build tasks.

### Screencast:  

[<img src="https://img.youtube.com/vi/pfiaKuXg8nI/0.jpg" href="Click to Watch" title="Click to Watch" height="200" width="350">](https://youtu.be/pfiaKuXg8nI)

## References

* [Ansible documentation](http://docs.ansible.com/ansible/latest/index.html)
* [AWS documentation](https://aws.amazon.com/documentation/)
* [Jenkins documnetation](https://jenkins.io/doc/)
* [Jenkins Job Builder](https://docs.openstack.org/infra/jenkins-job-builder/builders.html)
* [MongoDB documentation](https://docs.mongodb.com/manual/)
* [Environment variables in Jenkins](https://wiki.jenkins.io/display/JENKINS/EnvInject+Plugin)
