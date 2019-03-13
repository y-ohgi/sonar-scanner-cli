FROM openjdk:alpine

ENV SONAR_VERSION=3.3.0.1492

RUN set -x \
  && apk add --no-cache curl unzip \
  && curl -o /tmp/sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_VERSION}-linux.zip \
  && mkdir /opt \
  && unzip -d /opt /tmp/sonar-scanner-cli.zip \
  && ln -s /opt/sonar-scanner-${SONAR_VERSION}-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner \
  && ln -sf ${JAVA_HOME}/bin/java /opt/sonar-scanner-${SONAR_VERSION}-linux/jre/bin/java \
  && rm /tmp/*

WORKDIR /scan

ENTRYPOINT ["sonar-scanner"]
