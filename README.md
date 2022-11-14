## GitTemplates

This Template contains useful command blocks for Git setup and configuration.
  
### <Repo> Setup from CLI:

```
git init
git add -A
git commit -m "add project to existing repo"
git remote add origin https://github.com/Georges034302/<Repo>.git
git push -u -f origin master
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


### MySQL Localhost Configuration:
*Database name: bookstoredb*
*Update: application.properties in the resources directory with your SQL parameters*
```
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL5Dialect
spring.datasource.url=jdbc:mysql://${YOUR_HOSTNAME:localhost}:<SQL-PORT></SQL-PORT>/bookstoredb?serverTimezone=UTC
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.username=<SQL-Username>
spring.datasource.password=<SQL-Password>
```

### ERRATA: CORS policy: No 'Access-Control-Allow-Origin':
*In case the CORS block requests to resources in local host*

* Option 1 (Easy Fix): Add the proper annotation in the back-end for the mapping functions
```
 @CrossOrigin(origins = "http://localhost:3000")

```

* Option 2 (Lazy Fix): Add CORS extension to your browser
```
https://mybrowseraddon.com/access-control-allow-origin.html

```

* Option 3 (Back-end Option): Add a configuration file for the CORS in the Spring Boot
```
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class AppCorsConfiguration {
    @Bean
    public FilterRegistrationBean corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);
        config.addAllowedOrigin("*");
        config.addAllowedHeader("*");
        config.addAllowedMethod("*");
        source.registerCorsConfiguration("/**", config);
        FilterRegistrationBean bean = new FilterRegistrationBean(new CorsFilter(source));
        bean.setOrder(0);
        return bean;
    }
}

```

* Option 4 (Node Server Option): Create Express Server With API Endpoints
*Ref: https://www.stackhawk.com/blog/react-cors-guide-what-it-is-and-how-to-enable-it *
```
mkdir cors-server && cd cors-server 
npm init -y 
npm i express 

```

*Then create app.js*
```
const express = require('express');
const app = express();
app.get('/', (req, res) => {
    res.send('Welcome to CORS server')
})
app.get('/cors', (req, res) => {
    res.send('This has CORS enabled')
})
app.listen(8080, () => {
    console.log('listening on port 8080')
})

```

*Then setup the React App by updating App.js*
```
import { useEffect, useState } from 'react';
import './App.css';
function App() {
  const makeAPICall = async () => {
    try {
      const response = await fetch('http://localhost:8080/', {mode:'cors'});
      const data = await response.json();
      console.log({ data })
    }
    catch (e) {
      console.log(e)
    }
  }
  useEffect(() => {
    makeAPICall();
  }, [])
  return (
    <div className="App">
      <h1>React Cors Guide</h1>
    </div>
  );
}
export default App;
```
