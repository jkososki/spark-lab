FROM openjdk:8-slim-buster

ARG SPARK_VERSION=2.4.4
ARG HADOOP_VERSION=2.7
ARG SCALA_VERSION=2.12.10

ENV SCALA_HOME=/usr/local/scala
ENV SPARK_HOME=/usr/local/spark

# Add Deps
RUN apt-get update && \
    apt-get install -y wget ca-certificates procps

# Install Scala
RUN mkdir "${SCALA_HOME}" && \
    cd /tmp && \
    wget --no-verbose --show-progress --progress=dot:giga "https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar -xzf scala-${SCALA_VERSION}.tgz && \
    mv scala-${SCALA_VERSION}/* ${SCALA_HOME} && \
    rm -rf /tmp/*

# Install Python
RUN apt-get install -y python3 python3-pip && \
    python3 -m pip install --upgrade pip && \
    pip3 install pyspark && \
    ln -s /usr/bin/python3 /usr/bin/python

# Install Spark
RUN cd /tmp && \
    mkdir "${SPARK_HOME}" && \
    wget --no-verbose --show-progress --progress=dot:giga "http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}/* ${SPARK_HOME} && \
    rm -rf /tmp/*

RUN apt-get autoremove -y && apt-get autoclean -y

ENV PYSPARK_PYTHON=python3
ENV PYTHONPATH="${SPARK_HOME}/python:${PYTHONPATH}"
ENV PATH="${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${SCALA_HOME}/bin:${PATH}"