FROM node:alpine

WORKDIR /app

COPY ./app .
RUN npm install
RUN npm run build

ENV PORT=3000

CMD [ "node", "build/index.js" ]
