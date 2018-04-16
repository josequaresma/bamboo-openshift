Welcome to the repo on getting bamboo server and bamboo agent setup in OpenShift

- templates based from: https://github.com/sclorg/nodejs-ex/blob/master/openshift/templates/nodejs.json

- agent configuration based on https://confluence.atlassian.com/bamboo/getting-started-with-docker-and-bamboo-687213473.html and https://github.com/audreyr/docker-bamboo-agent/blob/master/Dockerfile

- server configuration based on https://confluence.atlassian.com/bamboo/installing-bamboo-on-linux-289276792.html and https://github.com/audreyr/docker-bamboo-server/blob/master/Dockerfile

HOW-TO
Creating Bamboo Server the simple way:
- oc project YOUR_PROJECT
- oc new-app https://github.com/josequaresma/bamboo-openshift --context-dir=bamboo-server/dockerfile --name=bamboo-server -l name=bamboo-server