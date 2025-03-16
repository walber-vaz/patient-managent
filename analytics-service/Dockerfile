FROM maven:3.9.9-eclipse-temurin-21 AS build_image

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:21-jdk-slim AS run_image

WORKDIR /app

COPY --from=build_image /app/target/analytics-service-0.0.1-SNAPSHOT.jar ./analytics-service.jar

EXPOSE 4002

ENTRYPOINT ["java", "-jar", "analytics-service.jar"]