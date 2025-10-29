FROM maven:latest AS build
WORKDIR /build
COPY . /build
RUN mvn clean package -DskipTests

FROM openjdk:25-oraclelinux9
WORKDIR /app
COPY --from=build /build/target/*.jar app.jar
EXPOSE 80
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=80"]
