FROM nginx:alpine
MAINTAINER Ed Asriyan <ed@asriyan.me>

RUN apk update && apk add nodejs

WORKDIR /application

# Install dependencies
ADD package.json .
RUN npm install

# Copy sources
ADD app ./app
ADD public ./public
ADD webpack.config.js .
ADD nginx.conf /etc/nginx/nginx.conf

# Generate bundle
RUN npm run generate_bundle

# Copy generated files
RUN cp -R public/static/. /usr/html/

# Remove unnecessary source files
RUN rm -fr /application
