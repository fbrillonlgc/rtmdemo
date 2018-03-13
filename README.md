# rtmdemo

## Overview
Big Data Demo, using
- RTM Open Data for trains position and delays in real-time
- Nifi as acquisition and transformation engine
- Azure Data Lake via WebHDFS for Data Lake Storage
- Azure Data Lake Analytics for batch transformation
- Power BI for Dashboards


## Pre-requisites
The following pre-requisites are needed for the project to be built and deployed properly
- CentOs 7.4+ with Docker CE installed
	- https://docs.docker.com/install/linux/docker-ce/centos/#install-docker-ce
- xmvn installed
	- sudo yum install xmvn
- Logged In to a docker-hub account (docker username is used to name the docker image)
	- docker login
- Access token for RTM Data
	-


## Configuration
Add your credentials to the rtmdemo.properties file.
- Copy the rtmdemo.properties.template file to rtmdemo.properties
	- cp conf/rtmdemo.properties.template conf/rtmdemo.properties
- Update the properties in the file with your own configuration.

Note that the file rtmdemo.properties is ignored by git (.gitignore) intentionally to avoid commiting credentials to the public GitHub repository by mistake. The file must however be present in the ./conf directory in order to properly build the docker image.


## Building
This will create java package, the docker image and push the image to docker hub into your own account
- ./sh/build.sh


## Deploy
This will pull the image from docker hub and start a container with it.
- ./sh/deploy.sh

Note that it will destroy any previous container of the same name. The data generated by the container is persisted under a volume.


## To Do
- Reorganize all files under a single Maven project
- Port build.sh and deploy.sh to Maven (pom.xml)

## Known Issues
- The field trip_updates.start_time sometimes contains an hour past 24h, i.e. 24h30 for example. This is flagged as an error by PowerBI when importing the data from the Data Lake.
