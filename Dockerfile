FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# WE NEED THE FOLLOWING LINE TO EXPORT PORT ON ELASTIC BEANSTALK
# DOES NOTHING ON LOCAL ENV
# ELASTIC BEANSTALK USES THIS INFO TO KNOW WHAT PORT TO MAP
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

