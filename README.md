# Templates

Useful command templates for Git, development environments, databases, Linux, and common development tasks.

---

## Git Repository Setup

### Create and Push a New Repository

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/<username>/<repository>.git
git push -u origin main
```

### Clone an Existing Repository

```bash
git clone https://github.com/<username>/<repository>.git
cd <repository>
```

### Common Git Commands

```bash
git status
git add .
git commit -m "<commit-message>"
git pull
git push
```

---

## GitHub CLI Authentication

Check GitHub CLI authentication:

```bash
gh auth status
```

Login interactively:

```bash
gh auth login
```

Login using a token:

```bash
gh auth logout
unset GITHUB_TOKEN
echo "<token>" | gh auth login --with-token
gh auth status
```

> Avoid storing GitHub tokens directly in scripts or repositories.

---

## SSH

Connect to a remote Linux host:

```bash
ssh <username>@<host>
```

Example:

```bash
ssh azureuser@<public-ip>
```

Copy a directory to a remote host:

```bash
scp -r <local-directory> <username>@<host>:<remote-directory>
```

Example:

```bash
scp -r website azureuser@<public-ip>:~
```

---

## Linux Web Server Deployment

Copy website files into the standard web root:

```bash
ssh <username>@<host>

cd <website-directory>

sudo cp -R . /var/www/html/
```

---

## Python Virtual Environment

### Windows PowerShell

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

py -m venv .venv

.venv\Scripts\Activate.ps1
```

### Linux/macOS

```bash
python3 -m venv .venv

source .venv/bin/activate
```

### Install Packages

```bash
python -m pip install <package-name>
```

Install dependencies from a requirements file:

```bash
python -m pip install -r requirements.txt
```

### Save Dependencies

```bash
python -m pip freeze > requirements.txt
```

### Deactivate Environment

```bash
deactivate
```

---

## MySQL CLI

Connect to MySQL:

```bash
mysql -h <host> -P 3306 -u <username> -p
```

Connect to localhost:

```bash
mysql -h localhost -P 3306 -u root -p
```

---

## MySQL Backup and Restore

### Backup

```bash
mysqldump \
  --single-transaction \
  -h <source-host> \
  -u <username> \
  -p \
  <database> > backup.sql
```

### Restore

```bash
mysql \
  -h <destination-host> \
  -u <username> \
  -p \
  <database> < backup.sql
```

---

## Node.js Project Setup

Initialize a Node.js project:

```bash
npm init -y
```

Install a dependency:

```bash
npm install <package-name>
```

Install development dependencies:

```bash
npm install --save-dev <package-name>
```

Run a project:

```bash
npm start
```

---

## Express.js Setup

Initialize the project:

```bash
npm init -y
```

Install Express:

```bash
npm install express
```

Install Nodemon as a development dependency:

```bash
npm install --save-dev nodemon
```

Run the server directly:

```bash
node server.js
```

Run using Nodemon:

```bash
npx nodemon server.js
```

---

## Compile and Run C

Compile:

```bash
gcc -Wall <source.c> -lm -o <output>
```

Run:

```bash
./<output>
```

Example:

```bash
gcc -Wall main.c -lm -o main
./main
```

---

## Find a Process Using a Port

### Linux

```bash
sudo lsof -i :8080
```

or:

```bash
ss -ltnp | grep :8080
```

Kill a process:

```bash
kill <PID>
```

Force termination if necessary:

```bash
kill -9 <PID>
```

### Windows

```powershell
netstat -ano | findstr :8080
```

Kill the process:

```powershell
taskkill /F /PID <PID>
```

---

## Bash Prompt

Temporary custom prompt:

```bash
PS1='\u@\h:\W\$ '
```

To make it permanent, add the configuration to:

```text
~/.bashrc
```

and reload:

```bash
source ~/.bashrc
```

---

## Grep Colour Output

Use:

```bash
grep --color=auto "<pattern>" <file>
```

Optional Bash alias:

```bash
alias grep='grep --color=auto'
```

Add the alias to `~/.bashrc` if you want it enabled permanently.
