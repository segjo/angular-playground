#Build der Anwendung
FROM buildkite/puppeteer:latest as build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run test:ci
RUN npm run build

#Deploy der Anwendung
FROM nginx
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/dist/hello-angular /usr/share/nginx/html