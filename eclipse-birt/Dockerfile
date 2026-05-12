#
# To build:
#  docker build -t birt:4.4.2 .
#
# To run:
#  docker run --rm -p 8001:8080 -e FLAG="ctf{example}" birt:4.4.2
#

FROM eclipse-temurin:8-jdk-jammy

ARG BIRT_VERSION=4_4_2
ARG BIRT_BUILD=20150217
ARG BIRT_DROP=R-R1-4_4_2-201502171805
ARG TOMCAT_VERSION=8.5.100
ARG TOMCAT_MAJOR=8

ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl unzip ca-certificates fontconfig fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
        -o /tmp/tomcat.tar.gz \
    && mkdir -p "${CATALINA_HOME}" \
    && tar -xzf /tmp/tomcat.tar.gz -C "${CATALINA_HOME}" --strip-components=1 \
    && rm /tmp/tomcat.tar.gz \
    && rm -rf "${CATALINA_HOME}/webapps/"*

RUN curl -fsSL "https://archive.eclipse.org/birt/downloads/drops/${BIRT_DROP}/birt-runtime-${BIRT_VERSION}-${BIRT_BUILD}.zip" \
        -o /tmp/birt.zip \
    && unzip -q /tmp/birt.zip -d /tmp/ \
    && mv "/tmp/birt-runtime-${BIRT_VERSION}/WebViewerExample" "${CATALINA_HOME}/webapps/birt" \
    && mkdir -p /opt/birt \
    && mv "/tmp/birt-runtime-${BIRT_VERSION}/ReportEngine" /opt/birt/ReportEngine \
    && rm -rf /tmp/birt.zip /tmp/birt-runtime-${BIRT_VERSION}

ENV BIRT_HOME=/opt/birt/ReportEngine

RUN mkdir -p "${CATALINA_HOME}/webapps/ROOT"
COPY index.html "${CATALINA_HOME}/webapps/ROOT/index.html"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8004

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["catalina.sh", "run"]
