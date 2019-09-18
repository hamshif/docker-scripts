FROM puckel/docker-airflow:1.10.2

ARG AIRFLOW_HOME=/usr/local/airflow
## Adobe part start ##
USER root

ENV TER_VER=0.11.11

RUN apt-get update \
    && apt-get install git -y \
    && apt-get install unzip -y \
    && apt-get install wget -y \
    && apt-get install -y vim \
    && apt-get install -y net-tools \
    && apt-get install -y netcat \
    && apt-get install -y telnet \
    && apt-get install -y iputils-ping \
    && apt-get install -y sudo \
    && apt install -y openssh-server \
    && apt-get install -y lsb-release \
    && apt-get install -y gnupg

RUN wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip \
    && unzip terraform_${TER_VER}_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm ./terraform_${TER_VER}_linux_amd64.zip \
    && terraform --version

#RUN pip install --upgrade pip

RUN pip install jprops python_terraform

RUN usermod -aG sudo airflow \
    && mkdir -p ${AIRFLOW_HOME}/data/dags

RUN mkdir /var/run/sshd \
    && echo 'root:testssh' | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile \
    && echo "airflow:airflow" |chpasswd

## Adobe part end ##

RUN rm ./airflow.cfg
COPY config/airflow.cfg .

RUN rm /entrypoint.sh
COPY script/entrypoint.sh /entrypoint.sh

COPY config/requirements.txt .
RUN pip install -r requirements.txt

# Git permissions for gcp
# Every User must get this script for his own environment!!!
#COPY credentials/google-source-credentials.sh .
#COPY credentials/google_source_credentials.py .
#
##
#RUN chmod 777 google_source_credentials.py \
#    && ./google_source_credentials.py

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


USER airflow
# run google source credentials
# run google cloud sdk as airflow
RUN sudo mkdir -p /opt/service_account

ENV GOOGLE_APPLICATION_CREDENTIALS="/opt/service_account/gcp-service-account-credentials.json"

#COPY credentials/gcp-service-account-credentials.json $GOOGLE_APPLICATION_CREDENTIALS


#RUN ./google_source_credentials.py \
#    && rm google-source-credentials.sh

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN sudo apt-get -y update
RUN sudo apt-get install -y google-cloud-sdk


#RUN gcloud -q auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS --project=wielder-datalake-dev


WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
CMD ["webserver"]
# set default arg for entrypoint
