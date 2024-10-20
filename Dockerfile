FROM ubuntu

# add config to install terraform
RUN apt-get update && apt-get install -y wget gnupg software-properties-common
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list

RUN apt-get update
RUN apt-get -y install \
    terraform ssh ansible

WORKDIR /apps

COPY id_rsa id_rsa
COPY id_rsa.pub id_rsa.pub

RUN chmod 600 id_rsa

COPY init.sh init.sh
RUN chmod u+x init.sh

COPY main.tf main.tf

COPY main.yaml main.yaml

CMD [ "./init.sh" ]