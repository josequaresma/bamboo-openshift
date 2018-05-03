FROM java:8
MAINTAINER Jose Quaresma (@josequaresma) 

# Based from Audrey Roy Greenfeld (@audreyr): https://github.com/audreyr/docker-bamboo-agent/blob/master/Dockerfile

# Config vars
ENV BAMBOO_AGENT_HOME /usr/sbin/bamboo-agent-home
ENV BAMBOO_AGENT_INSTALL /opt/atlassian/bambooagent
ENV BAMBOO_VERSION 6.5.0
ENV BAMBOO_AGENT_JAR atlassian-bamboo-agent-installer-$BAMBOO_VERSION.jar
ENV BAMBOO_AGENT $BAMBOO_AGENT_HOME/bin/bamboo-agent.sh
ENV BAMBOO_SERVER bamboo-server

# Copy the scripts
COPY ./run.sh /tmp/run.sh
COPY ./bamboo-capabilities.properties $BAMBOO_AGENT_HOME/bin/bamboo-capabilities.properties

# Install Atlassian Bamboo Agent and helper tools and setup initial home
# directory structure.
RUN set -x \
    && chmod -R 777            /tmp/run.sh \
#    && chown -R daemon:daemon  /tmp/run.sh \
    && mkdir -p                "${BAMBOO_AGENT_HOME}" \
    && chmod -R 777            "${BAMBOO_AGENT_HOME}" \
#    && chown -R daemon:daemon  "${BAMBOO_AGENT_HOME}" \
    && mkdir -p                "${BAMBOO_AGENT_INSTALL}" \
    && chmod -R 777            "${BAMBOO_AGENT_INSTALL}" \
#    && chown -R daemon:daemon  "${BAMBOO_AGENT_INSTALL}" \
    && chmod -R 777            "${BAMBOO_AGENT_HOME}/bin/bamboo-capabilities.properties"
#    && chown -R daemon:daemon  "${BAMBOO_AGENT_HOME}/bin/bamboo-capabilities.properties"

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
#USER daemon:daemon

# Expose web and agent ports (what ports does agent need?)
EXPOSE 8085
EXPOSE 54663

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME ["/var/atlassian/bambooagent"]

# Set the default working directory as the installation directory.
WORKDIR ${BAMBOO_AGENT_HOME}

# Run agent as a foreground process by default.
CMD ["/tmp/run.sh", "-fg"]