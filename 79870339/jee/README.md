# Jakarta EE WildFly Demo

This is a simple Jakarta EE 10 application that demonstrates how to use EL (Expression Language) with custom packages in JSP.

## Project Structure

```
.
├── pom.xml
├── README.md
└── src
    └── main
        ├── java
        │   └── com
        │       └── example
        │           └── web
        │               ├── ExampleELContextListener.java
        │               └── Suit.java
        └── webapp
            └── index.jsp
```

## Key Files

### Suit.java
An enum representing card suits: hearts, spades, diamonds, clubs.

### ExampleELContextListener.java
A servlet context listener that imports the `com.example.web` package for direct EL access. This listener:
- Registers itself as an ELContextListener on application startup
- Imports the com.example.web package for EL expressions

### index.jsp
A simple JSP that demonstrates EL access to the Suit enum.

## Prerequisites

- Java 17 or higher
- Maven 3.8 or higher
- WildFly 31 or compatible Jakarta EE 10 server

## Building the Project

```bash
mvn clean package
```

This will generate `target/jakartaee-demo.war`.

## Deploying to WildFly

### Option 1: Using WildFly Maven Plugin

```bash
mvn wildfly:run
```

This will start WildFly and deploy the application.

### Option 2: Manual Deployment

1. Start WildFly
2. Copy `target/jakartaee-demo.war` to `$WILDFLY_HOME/standalone/deployments/`
3. Wait for deployment to complete

## Accessing the Application

Open your browser and go to:
```
http://localhost:8080/jakartaee-demo/
```

You should see "hearts" displayed on the page.