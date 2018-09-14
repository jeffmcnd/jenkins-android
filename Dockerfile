FROM jenkins:lts
LABEL maintainer="Jeffrey McNally-Dawes"

USER root

ENV ANDROID_SDK_HOME /opt/android-sdk
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_SDK /opt/android-sdk
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH ${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

RUN apt-get update

WORKDIR /opt

ARG SDK_FILE=android-sdk.zip

RUN wget -O ${SDK_FILE} https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip ${SDK_FILE} -d $ANDROID_HOME \
    && rm ${SDK_FILE}

RUN mkdir $HOME/.android && touch $HOME/.android/repositories.cfg

RUN sdkmanager --update
RUN sdkmanager "platforms;android-28" "build-tools;28.0.2" "extras;android;m2repository"
RUN yes | sdkmanager --licenses

VOLUME /opt/android-sdk
