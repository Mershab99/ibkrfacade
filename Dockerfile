# Stage 1: Build the application with Maven
FROM maven:3.8.7-openjdk-18 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .

# Download dependencies (this step is separate to leverage Docker caching)
RUN mvn dependency:go-offline -B

# Copy the entire project and build the application
COPY . .

# Build the application
RUN mvn clean install -DskipTests

# Stage 2: Run the application
FROM openjdk:3-openjdk-18-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the first stage
COPY --from=build /app/target/ibkrfacade-1.0-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8082

# Command to run the application
CMD ["java", "-jar", "app.jar"]
