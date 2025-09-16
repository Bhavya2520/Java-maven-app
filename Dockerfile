# Stage 1: Build the project with Maven
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the jar
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy jar from the build stage
COPY --from=build /app/target/java-maven-app-1.1.0-SNAPSHOT.jar app.jar

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
