#Base Image node:12.18.4-alpine
#FROM node:12.18.4-alpine
FROM node:16.19.1 as build


#Set working directory to /app
WORKDIR /app

RUN npm install -g @angular/cli

#Set PATH /app/node_modules/.bin
#ENV PATH /app/node_modules/.bin:$PATH


#Copy package.json in the image
COPY package.json ./


#Run npm install command
RUN npm install


#Copy the app
COPY . ./

EXPOSE 3000

#Start the app
CMD ["node", "./src/server.js"]
