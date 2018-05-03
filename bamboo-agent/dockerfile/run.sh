#!/usr/bin/env bash

# Exit on errors
#set -e

BAMBOO_INSTALLER=$BAMBOO_AGENT_INSTALL/$BAMBOO_AGENT_JAR
if [ -f $BAMBOO_INSTALLER ]; then
	echo "-> Installer already found at $BAMBOO_INSTALLER. Skipping download."
else
  # Download the agent from $DOWNLOAD_URL
  DOWNLOAD_URL=http://$BAMBOO_SERVER:8085/agentServer/agentInstaller/$BAMBOO_AGENT_JAR
  curl -SL $DOWNLOAD_URL -o $BAMBOO_AGENT_INSTALL/$BAMBOO_AGENT_JAR
fi

# Fix permissions
#chown -R daemon:daemon $BAMBOO_INSTALLER
chmod -R 777 $BAMBOO_INSTALLER

BAMBOO_AGENT=$BAMBOO_AGENT_HOME/bin/bamboo-agent.sh
if [ ! -f $BAMBOO_AGENT ]; then
  # Run the agent installer
  if [[ -z $BAMBOO_TOKEN ]]; then
    echo "-> Running Bamboo Installer without token since BAMBOO_TOKEN is not set as env variable..."
    java -Dbamboo.home=$BAMBOO_AGENT_HOME -jar $BAMBOO_AGENT_INSTALL/$BAMBOO_AGENT_JAR http://$BAMBOO_SERVER:8085/agentServer/
  else
    echo "-> Running Bamboo Installer with token since BAMBOO_TOKEN is set as env variable..."
    java -Dbamboo.home=$BAMBOO_AGENT_HOME -jar $BAMBOO_AGENT_INSTALL/$BAMBOO_AGENT_JAR http://$BAMBOO_SERVER:8085/agentServer/ -t $BAMBOO_TOKEN
  fi
fi

# Fix permissions
#chown -R daemon:daemon $BAMBOO_AGENT
chmod -R 777 $BAMBOO_AGENT

# Run the Bamboo agent
# $BAMBOO_AGENT console

# Making sure script does not terminate
while true; do sleep 3600; done