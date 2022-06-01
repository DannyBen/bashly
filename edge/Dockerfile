FROM dannyben/alpine-ruby

ENV PS1 "\n\n>> bashly \W \$ "
RUN apk add --no-cache git

WORKDIR /bashly
RUN git clone --depth 1 https://github.com/DannyBen/bashly.git .
RUN gem build bashly.gemspec
RUN gem install bashly*.gem

WORKDIR /app
RUN rm -rf /bashly

VOLUME /app
ENTRYPOINT ["bashly"]