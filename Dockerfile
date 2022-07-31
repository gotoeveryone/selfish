FROM debian:bullseye-slim

RUN apt-get update && \
  apt-get install -yq \
  lsb-release \
  curl

ENV AGENT_URL https://amazon-ssm-ap-northeast-1.s3.amazonaws.com/latest/debian_amd64/amazon-ssm-agent.deb

RUN curl ${AGENT_URL} -o amazon-ssm-agent.deb && \
  dpkg -i amazon-ssm-agent.deb && \
  rm -f amazon-ssm-agent.deb

WORKDIR /opt/amazon/ssm/

CMD ["amazon-ssm-agent", "start"]
