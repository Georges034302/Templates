## GitTemplates

This Template contains useful command blocks for Git setup and configuration.
  
### <Repo> Setup from CLI:

```
git init
git add -A
git commit -m "add project to existing repo"
git remote add origin https://github.com/<UserID>/<Repo>.git
git push -u -f origin master
```
### Configure GitHub Access with TOKEN (CLI):

```
gh auth logout
unset GITHUB_TOKEN
echo "TOKEN" | gh auth login --with-token
gh auth status
```

### Shorten Bash Prompt
```
PS1='\[\033[01;31m\]\u\[\033[01;35m\]@\[\033[01;32m\]\h\[\033[01;34m\]_\W\[\033[01;33m\]$\[\033[00m\] '
```

### Enable and Setup Python Env on VsCode:

```
- On Windows:
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process 
  py -3 -m venv .venv    
  .venv\scripts\activate

- On Linux:
  python3 -m venv .venv    
  source .venv/bin/activate

- To install a package in the workspace:
  python -m pip install <package-name>
```

### START/STOP MS SQL SERVICE (CMD or PowerShell):

```
- Open CMD in Administrator mode:
  net start SQLServerAgent
  net stop SQLServerAgent    

- Open PowerShell:
  Get-Service -Name MSSQLSERVER
  Set-Service -Name MSSQLSERVER -Status Running -PassThru
  Get-Service -Name MSSQLSERVER

```
  
### Connect to MySQL DB from CLI:

```
In CLI Type the command:
  mysql -u <username> -p -h <end-point> -P PORT
  mysql -h <mysql-instance-dns> -P 3306 -u <username> -p

On Localhost:
  mysql -u root -p -P 1433
  
```

### Migrate MySQL Database:

* Step 1: Create database backup file
```

mysqldump --single-transaction -h (old_database_host) -u (old_database_username) -p (old_database_name) > backup.sql

```
* Step 2: Restore database from backup file
```

mysql -h (new_database_host) -u (new_database_username) -p -D (new_database_name) < backup.sql

```

### Create and Run REACT app

```
npx create-react-app@5.0.0 my-app

npm start
```

### Building ThreeJS Project in VS Code:

* Download and extract Three JS package from: https://threejs.org/
* Create a folder called CGLabs
* Open that folder in vscode and create a subfolder called 'js'
* Copy 'three.js' from the 'ThreeJS/build' folder into 'js'
* Create index.html in CGLabs [by default vscode uses emmet to generate html snipets]
* Download 'Live Server extension' in vs code [live server provides local server live-runtime for static apps]
* Download Javascript ES6/ES7 extension
* Download Javascript Babel extension
* Create lab for each lab to develop threejs apps inside the labs folder
* Insert the labs js scripts into index.html and load using live server


### Enable ThreeJS autocomplete in VS Code:

* Install nodejs for your operating system [https://nodejs.org/en/download/]
* In the vscode terminal run the commands:
```
sudo apt install node
sudo apt install npm
sudo apt update
sudo apt upgrade
```
* In the vscode terminal run the command:  
```
npm init -y
[This command will generate the package.json file for your project]
```
* In the vscode terminal run the command:  
```
npm install @types/three 
[This command will install the ThreeJS definition module in vscode]
```
### Netbeans Fix Script:
```
#!/bin/bash

cd ~
rm -rf .netbeans*
rm -rf /tmp/`whoami`
```

### Compile and Run C Script:
```
#!/bin/bash

gcc -Wall $1 $2 -lm -o $3

./$3
echo
```
### Setting Grep output coloring
```
add: alias grep='grep --color=auto' to the .bashrc in home directory

or (bad fix)
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
echo
```

### Find and Kill Process Windows
```
netstat -pant | grep "8080"

taskkill /F /PID <process ID>
```

### Environment Setup:

* Install Node.JS and npm package manager for your OS
* Create a new directory and open the directory with vscode
* Create and initialize node.js app
  ```
    npm -y init
  ```
* Install express.js dependencies
  ```
    npm install express
  ```
* Install nodemon to automatically refresh server code
  ```
    npm install -g nodemon
  ```
* Install ejs library from vscode extension then run the command
  ```
    npm install ejs
  ```
* Start the express app (main-server at root directory: server.js)
  ```
    nodemon server.js
  ```


