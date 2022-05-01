FROM strapi/base:alpine

WORKDIR /

COPY ./package.json ./

RUN yarn install

COPY . .

ENV NODE_ENV production

RUN yarn build

EXPOSE 1337

CMD yarn start
