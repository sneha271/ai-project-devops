#Satge1: build jar (from base image and stage named as build , so 2nd stage can refer it)
FROM eclipse-temurin:21-jdk AS build
#like cd /app
WORKDIR /app
#copy my pom.xml to the current directory ./
COPY mvnw pom.xml ./
#copy my pc mvn wrapper inside the container mvn wrapper
COPY .mvn .mvn
#Run it while building the jar
RUN chmod +x mvnw && ./mvnw -q dependency:go-offline
#copy my src to the image src
COPY src src
#clean the old jar and pacakge it
RUN ./mvnw -q clean package -DskipTests

#stage2:final image
FROM eclipse-temurin:21-jre
WORKDIR /app
RUN useradd -r -u 10001 appuser
COPY --from=build /app/target/*.jar app.jar
USER 10001
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]