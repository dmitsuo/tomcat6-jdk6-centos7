FROM davimss/centos7-jdk6:6u45

USER root

ENV TOMCAT_MAJOR 6
ENV TOMCAT_VERSION 6.0.29
ENV TOMCAT_DOWN_FILE apache-tomcat-$TOMCAT_VERSION.tar.gz

ENV CATALINA_HOME /opt/tomcat-$TOMCAT_VERSION
ENV PATH $CATALINA_HOME/bin:$PATH

RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN set -x \
    && curl -o $TOMCAT_DOWN_FILE -L https://www.dropbox.com/s/qoknvh8d1vairkr/$TOMCAT_DOWN_FILE?dl=1 \
    && tar -xvf $TOMCAT_DOWN_FILE --strip-components=1 \
    && rm bin/*.bat \
    && rm $TOMCAT_DOWN_FILE \
    && rm -rf webapps/docs \
    && rm -rf webapps/examples \
    && chown caos:caos -Rf /opt \
    && chmod -Rf 755 /opt \
    && ln -s $CATALINA_HOME /opt/tomcat

USER caos

EXPOSE 8080

CMD ["catalina.sh", "run"]