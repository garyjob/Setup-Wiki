# Jenkins 

## Installation  
### MacOS X
  brew install jenkins

#### Start manually
  java -jar /usr/local/opt/jenkins/libexec/jenkins.war

#### Start service
  sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist

#### Stop service
  sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist

#### Further references
https://wiki.jenkins-ci.org/display/JENKINS/Thanks+for+using+OSX+Installer


### Ubuntu 
  - wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
  - sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
  - sudo apt-get update
  - sudo apt-get install jenkins  




## Folder structure

### Jenkins settings directory
  ~/.jenkins
  
  MacOS X - Jenkins settings directory ~/.jenkins
  Copy 
    /config.xml
    /jobs/[JOB]

### Jenkins Command line

Download package at http://localhost:8080/cli

Package installation 
```console
vagrant ssh jks -c "java -jar /vagrant/lib/tools/jenkins-cli.jar -s http://localhost:8080/ install-plugin http://updates.jenkins-ci.org/latest/performance.hpi"
```


## Plugins
### Integration with JMeter

  install plugin — name : performance plugin
  create Job — type 

  For further references on setup of Job refer to
  http://ribblescode.wordpress.com/2012/04/16/how-to-automate-jmeter-tests-with-maven-and-jenkins-hudson-8/

  For further references on preloading of Jenkins instance with pre-configurations refer to 
  https://wiki.jenkins-ci.org/display/JENKINS/Administering+Jenkins

### Integration with GitHub
#### Required plugins for installation
- GitHub Api plugin
- GitHub Authentication Plugin
- GitHub plugin
- GitHub Pull Request Builder
- Jenkins GIT client plugin
- Jenkins GIT plugin

### Setup configurations

- Login to jenkins account on local computer
```console
sudo su jenkins
```

- Generate the public key for the jenkins account
```console
mkdir ~/.ssh
ssh-keygen -t rsa
```

- Add the jenkins public key to your GitHub account
- Add to known_hosts by typing yes
git ls-remote -h git@github.com:garyjob/hello-go.git
```

### Contents Of org.jenkins-ci.plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>StandardOutPath</key>
    <string>/var/log/jenkins/jenkins.log</string>
    <key>StandardErrorPath</key>
    <string>/var/log/jenkins/jenkins.log</string>
	<key>EnvironmentVariables</key>
	<dict>
		<key>JENKINS_HOME</key>
		<string>/Users/Shared/Jenkins/Home</string>
	</dict>
	<key>GroupName</key>
	<string>daemon</string>
	<key>KeepAlive</key>
	<true/>
	<key>Label</key>
	<string>org.jenkins-ci</string>
	<key>ProgramArguments</key>
	<array>
                <string>/bin/bash</string>
		<string>/Library/Application Support/Jenkins/jenkins-runner.sh</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>UserName</key>
	<string>jenkins</string>
        <key>SessionCreate</key>
	<true />
</dict>
</plist>

```
