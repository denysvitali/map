FROM node:14

USER node
RUN mkdir -p /home/node/.npm-global \
             /home/node/waarzitje/map \
             /home/node/waarzitje/map/dist
             
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH
RUN npm -g config set user "$USER" && \
    npm i -g yarn && \
    printf "Node version %s, npm version %s, yarn version %s\n\n" "$(node -v)" "$(npm -v)" "$(yarn -v)"

WORKDIR /home/node/waarzitje/map
COPY ["package.json", "yarn.lock", "babel.config.js", "tsconfig.json", "vue.config.js", ".browserslistrc", ".env", ".env.local", ".eslintrc.js", "./"]
COPY ["public/", "./public/"]
COPY ["src/", "./src/"]

RUN yarn install

ENTRYPOINT ["yarn", "run"]
CMD ["build"]
