FROM maven:3.8-eclipse-temurin-8 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY WebContent ./WebContent
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk8
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
WORKDIR /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
