## C4 Context Analysis

###  C4 Level 1: System Context Analysis

| Reference # | Element Name | Element Type | Description | Interaction with Marathon Management System | Source/Justification |
|---|---|---|---|---|---|
| L1-001 | Race Director | Person | Plans and manages the marathon event | Manages race categories, routes, schedules and operational updates; monitors event activities and communicates changes | Race Director usage narrative |
| L1-002 | Participant | Person | Registers for and participates in the marathon | Registers, receives updates, views routes and start times, accesses tracking information and views results | Participant usage narrative |
| L1-003 | Volunteer Coordinator | Person | Organises and manages event volunteers | Assigns responsibilities, distributes training materials and communicates assignment changes | Volunteer Coordinator usage narrative |
| L1-004 | Spectator | Person | Follows and supports marathon participants | Views routes, identifies viewing locations and tracks selected runners | Spectator usage narrative |
| L1-005 | Vendor | Person | Participates in the marathon expo | Registers for the expo, selects a booth location and accesses authorised event information | Vendor usage narrative |
| L1-006 | City Services | External Organisation | Coordinates road closures, public safety and emergency support | Receives relevant route, schedule and operational information | Coordinate with city services business process |

### C4 Level 2: Container Analysis

| Reference # | Container Name | Container Type | Responsibility | Users Served | Communicates With | Data Used or Stored | NFR/Risk Justification |
|---|---|---|---|---|---|---|---|
| L2-001 | Web Application | Web Application | Provides browser-based access to marathon administration, registration, volunteer management, vendor services, race information and published results | Race Director, Participant, Volunteer Coordinator, Spectator and Vendor | Backend API | Displays registration, schedule, route, volunteer, vendor, tracking and results data received through the Backend API | Supports usability and broad network access; administrative functions require access control |
| L2-002 | Mobile Application | Mobile Application | Provides race-day access to schedules, routes, runner tracking, notifications and results | Participant and Spectator | Backend API, User Authentication and Notification Provider | Displays route, tracking, notification and results data received through authorised services | Supports mobility, timely updates and race-day availability; must remain responsive during peak demand |
| L2-003 | Backend API | Application/API | Implements marathon business rules and coordinates requests between applications, data stores and external systems | Web Application and Mobile Application users | Web Application, Mobile Application, Marathon Database and external systems | Processes registrations, schedules, volunteer assignments, vendor information, tracking events, notifications, feedback and results | Centralises business rules and access control; must support scalability, security, reliability and external-service failure handling |
| L2-004 | Marathon Database | Relational Data Store | Maintains the authoritative operational data for the marathon | Accessed indirectly through the Backend API | Backend API | Stores users, race categories, registrations, schedules, volunteer assignments, vendor details, timing records, official results and feedback | Supports data integrity, confidentiality, backup, recovery and controlled access |

### External Systems Analysis

| Reference # | External System Name | Responsibility | Connected Container | Data Sent to External System | Data Received from External System | Source/Justification |
|---|---|---|---|---|---|---|
| ES-001 | Payment Service | Processes registration and vendor payments | Backend API | Payment amount, transaction reference and payment token | Payment status and transaction confirmation | Architectural assumption supporting digital registration; verify against the backlog |
| ES-002 | Timing and Checkpoint System | Captures runner start, checkpoint and finish events | Backend API | Runner or timing-chip identifier and event configuration, where required | Checkpoint identifier, runner identifier, event time and finish time | Timing-chip distribution, real-time tracking and results business processes |
| ES-003 | Notification Provider | Delivers email, SMS and push notifications | Backend API | Recipient identifier, communication channel and notification content | Delivery status and failure information | Race Director, Participant and Volunteer Coordinator usage narratives |
| ES-004 | Mapping Service | Provides route and location information | Backend API | Route or location request | Route geometry, station locations, viewing locations and related map data | Participant and Spectator usage narratives |

---

## Cloud Selection Model

### Deployment Model

| Selected Deployment Model | Selection Justification | Key Risk | Risk Treatment |
|---|---|---|---|
| Public Cloud | Supports variable registration and race-day demand without requiring permanent infrastructure for peak capacity | Provider dependency and vendor lock-in | Use standard APIs, portable application containers, exportable data formats, tested backups and a documented recovery plan |

### C4 - L2 Cloud Deployment

| Internal C4 Element | Deployment Location | Selected Service Model | Selection Justification | AWS Service | Azure Service |
|---|---|---|---|---|---|
| Web Application | Public Cloud | PaaS | Managed hosting supports automated deployment, availability and event-demand scaling | AWS Amplify Hosting | Azure Static Web Apps |
| Mobile Application | User’s Mobile Device | Not Applicable | The application runs on the user’s device and accesses cloud services through the Backend API over HTTPS | N/A | N/A |
| Backend API | Public Cloud | PaaS | Managed application hosting reduces server administration and supports automatic scaling | AWS App Runner | Azure Container Apps |
| Marathon Database | Public Cloud | DBaaS | Managed relational storage provides backup, patching, monitoring and recovery | Amazon RDS for PostgreSQL | Azure Database for PostgreSQL |

### Cloud Capabilities & Services

| Cloud Capability | Selected Service Model | Selection Justification | AWS Service | Azure Service |
|---|---|---|---|---|
| User Authentication | Managed Identity Service | Provides user registration, login, authentication, authorisation and access-token management | Amazon Cognito | Microsoft Entra External ID |
| IoT Data Ingestion | IoT PaaS | Receives timing and checkpoint events from authorised race-day devices | AWS IoT Core | Azure IoT Hub |
| Streaming Data Ingestion | PaaS | Receives and streams high-volume race events for real-time processing | Amazon Kinesis Data Streams | Azure Event Hubs |
| Event Queue | PaaS | Buffers events and supports reliable asynchronous processing | Amazon SQS | Azure Service Bus |
| Serverless Event Processing | FaaS | Validates timing events, calculates race progress and identifies provisional winners | AWS Lambda | Azure Functions |
| Raw Race Data Storage | DSaaS | Stores raw timing events, imported files, logs and audit records | Amazon S3 | Azure Blob Storage |
| Live-Tracking Data Store | NoSQL DBaaS | Stores rapidly changing runner locations and checkpoint states | Amazon DynamoDB | Azure Cosmos DB |
| Operational Data Store | Relational DBaaS | Stores registrations, schedules, volunteers and official race results | Amazon RDS for PostgreSQL | Azure Database for PostgreSQL |
| Notification Delivery | Managed Communication Service | Delivers race updates, emergency alerts and approved result notifications | Amazon SNS and Amazon SES | Azure Communication Services and Azure Notification Hubs |
| Mapping and Location | Managed Location Service | Provides routes, station locations, viewing points and location information | Amazon Location Service | Azure Maps |

### External System Deployment Model

| External System | Selected Service Model | Responsibility | Connected Internal Element | AWS Integration | Azure Integration |
|---|---|---|---|---|---|
| Payment Service | SaaS | Processes registration and vendor payments | Backend API | Third-party payment provider connected through the Backend API | Third-party payment provider connected through the Backend API |
| Timing and Checkpoint Equipment | Specialist External System | Captures runner start, checkpoint and finish events | IoT Data Ingestion | AWS IoT Core | Azure IoT Hub |
| Mobile App Stores | External Distribution Platform | Distributes the Mobile Application to users’ devices | Mobile Application | Apple App Store and Google Play | Apple App Store and Google Play |

---

## Sample C4 Model using Mermaid

```mermaid
flowchart LR
    subgraph MMS["Marathon Management System"]
        direction TB

        WEB["Web Application<br/>[Container]"]
        MOBILE["Mobile Application<br/>[Container]"]
        API["Backend API<br/>[Container]"]
        DB[("Marathon Database<br/>[Container]")]

        WEB -->|"HTTPS/JSON"| API
        MOBILE -->|"HTTPS/JSON"| API
        API -->|"Reads and writes"| DB
    end

    AUTH["Authentication Service<br/>[External Software System]"]
    PAYMENT["Payment Service<br/>[External Software System]"]
    TIMING["Timing and Checkpoint System<br/>[External Software System]"]
    NOTIFY["Notification Provider<br/>[External Software System]"]
    MAPPING["Mapping Service<br/>[External Software System]"]

    API -->|"Validates access tokens"| AUTH
    API -->|"Processes payments"| PAYMENT
    TIMING -->|"Provides timing data"| API
    API -->|"Sends notifications"| NOTIFY
    API -->|"Requests route data"| MAPPING

```

## Cloud Architecture

<img width="2400" height="1500" alt="urban-marathon-cloud-architecture" src="https://github.com/user-attachments/assets/7c344081-3f9e-4a21-9366-a0289285c5e9" />

