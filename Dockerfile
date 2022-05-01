FROM strapi/base:alpine

# Install OpenSSH and set the password for root to "Docker!". In this example, "apk add" is the install instruction for an Alpine Linux-based image.
RUN apk add openssh \
     && echo "root:Docker!" | chpasswd

# Copy the sshd_config file to the /etc/ssh/ directory
COPY sshd_config /etc/ssh/

RUN /usr/bin/ssh-keygen -A


WORKDIR /

COPY ./package.json ./
# COPY ./yarn.lock ./

RUN yarn install

COPY . .

ENV NODE_ENV production

RUN yarn build

EXPOSE 1337 2222

CMD /usr/sbin/sshd -D -p 2222 & yarn develop
