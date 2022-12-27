#  Dockerfile for Node Express Backend

FROM node:18-alpine

WORKDIR /app

# Install Dependencies
COPY  . .

RUN npm install

# Exports
EXPOSE 5000

CMD ["npm","run", "server"]
