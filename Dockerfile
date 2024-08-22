FROM openjdk:17
WORKDIR /app
COPY target/ibkrfacade-1.0-SNAPSHOT.jar app.jar
EXPOSE 8082
CMD ["java", "-jar", "app.jar"]