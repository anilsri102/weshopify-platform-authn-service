#FROM openjdk:17-jdk-slim as build 

FROM openjdk:17-alpine

ARG WORK_DIR=/opt/authn-service
ARG ARTIFACT_NAME=weshopify-authn-service.jar
ARG SERVICE_PORT=5022

ENV FINAL_ARTIFACT=${ARTIFACT_NAME}

RUN mkdir ${WORK_DIR}

WORKDIR ${WORK_DIR}

COPY app-dir/target/${ARTIFACT_NAME} ${WORK_DIR}

EXPOSE ${SERVICE_PORT}

CMD [ "sh","-c", "java -jar ${FINAL_ARTIFACT}"]
