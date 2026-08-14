## Sample C4 Model using Mermaid

```mermaid
flowchart TB
    subgraph MMS["Marathon Management System"]
        WEB["Web Application<br/>[Container]"]
        MOBILE["Mobile Application<br/>[Container]"]
        API["Backend API<br/>[Container]"]
        DB[("Marathon Database<br/>[Container]")]
        
        WEB -->|"HTTPS/JSON"| API
        MOBILE -->|"HTTPS/JSON"| API
        API -->|"Reads and writes"| DB
    end

    PAYMENT["Payment Service<br/>[External Software System]"]
    TIMING["Timing and Checkpoint System<br/>[External Software System]"]
    NOTIFY["Notification Provider<br/>[External Software System]"]

    API -->|"Processes payments"| PAYMENT
    TIMING -->|"Provides timing data"| API
    API -->|"Sends notifications"| NOTIFY

```
