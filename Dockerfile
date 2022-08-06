FROM debian:bullseye-slim

RUN apt-get update && \
  apt-get install -yq \
  lsb-release \
  curl unzip jq

ENV AGENT_URL https://amazon-ssm-ap-northeast-1.s3.amazonaws.com/latest/debian_amd64/amazon-ssm-agent.deb

RUN curl ${AGENT_URL} -o amazon-ssm-agent.deb && \
  dpkg -i amazon-ssm-agent.deb && \
  rm -f amazon-ssm-agent.deb && \
  cp /etc/amazon/ssm/seelog.xml.template /etc/amazon/ssm/seelog.xml

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install && \
  rm -rf ./aws && \
  rm -f ./awscliv2.zip

WORKDIR /opt/amazon/ssm/

COPY ./entrypoint.sh /opt/amazon/ssm/

CMD ["/opt/amazon/ssm/entrypoint.sh"]
