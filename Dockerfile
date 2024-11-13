# stage-1
FROM amazoncorretto:11-alpine-jdk as builder
WORKDIR /app/source
COPY . .
RUN ./mvnw package
# ENTRYPOINT ["java", "-jar", "./target/datastore-0.0.4.jar"]

#stage-2
FROM amazoncorretto:11-alpine-jdk
COPY --from=builder /app/source/target/*.jar /app/app.jar
VOLUME /app
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app/app.jar"]