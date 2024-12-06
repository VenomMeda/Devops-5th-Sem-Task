#!/bin/bash

# Check if user provides a version
if [ -z "$1" ]; then
  echo "Usage: $0 <jenkins-version>"
  exit 1
fi

JENKINS_VERSION=$1

# Detect OS and package manager
if [ -f /etc/os-release ]; then
  source /etc/os-release
  if [[ "$ID_LIKE" == *"debian"* ]]; then
    PM="apt"
  elif [[ "$ID_LIKE" == *"rhel"* ]]; then
    PM="yum"
  else
    echo "Unsupported Linux distribution."
    exit 1
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  PM="brew"
else
  echo "Unsupported OS."
  exit 1
fi

# Install Jenkins
echo "Installing Jenkins $JENKINS_VERSION on $ID ($PM)..."

case $PM in
  apt)
    sudo apt update
    sudo apt install -y openjdk-11-jdk
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt install -y "jenkins=$JENKINS_VERSION"
    ;;
  yum)
    sudo yum install -y java-11-openjdk
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum install -y "jenkins-$JENKINS_VERSION"
    ;;
  brew)
    brew install java
    brew install jenkins-lts
    ;;
esac

echo "Jenkins $JENKINS_VERSION installed successfully."
