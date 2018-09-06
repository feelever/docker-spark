FROM centos:7
#FROM docker.io/frolvlad/alpine-oraclejdk8
MAINTAINER caigd <feelevercai@gmail.com> 

# 安装系统工具
RUN yum update -y
RUN yum upgrade -y
RUN yum install -y byobu curl htop man unzip nano wget
RUN yum clean all

# 安装 Java
ENV JDK_VERSION 8u131
ENV JDK_BUILD_VERSION b11
#RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" 
RUN  curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm > jdk-8u131-linux-x64.rpm  && rpm -i jdk-$JDK_VERSION-linux-x64.rpm; rm -f jdk-$JDK_VERSION-linux-x64.rpm;
ENV JAVA_HOME /usr/java/default
RUN yum remove curl;  yum clean all
WORKDIR spark

RUN \
  curl -LO 'http://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz' && \
  tar zxf spark-2.3.1-bin-hadoop2.7.tgz

RUN rm -rf spark-2.3.1-bin-hadoop2.7.tgz
RUN mv spark-2.3.1-bin-hadoop2.7/* ./

ENV SPARK_HOME /spark
ENV PATH /spark/bin:$PATH
ENV PATH /spark/sbin:$PATH
