FROM node:16-alpine

WORKDIR /app

COPY . .  

RUN npm install

RUN npm install http-proxy-middleware --save

RUN npx browserslist@latest --update-db

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]