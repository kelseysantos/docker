FROM node:alpine

WORKDIR /faceapp

COPY web ./

RUN cd /faceapp && npm i

EXPOSE 3000

CMD [ "npm", "start" ]