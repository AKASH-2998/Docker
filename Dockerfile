FROM schoolofdevops/maven:spring AS BUILD
WORKDIR /app
COPY . .
RUN mvn spring-javaformat:apply && \ 
    mvn package -DskipTests


FROM openjdk:8u201-jre-alpine3.9 AS RUN
WORKDIR /run
COPY --from=BUILD /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /run/petclinic.jar
EXPOSE 8080
CMD java -jar petclinic.jar