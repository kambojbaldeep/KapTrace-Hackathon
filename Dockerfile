# Use a Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use OpenJDK 8 for the final runtime 
FROM openjdk:8-jdk-slim
WORKDIR /app
COPY --from=build /app/target/pro-0.0.1-SNAPSHOT.war demo.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.war"]
