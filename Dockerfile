FROM dannyben/alpine-ruby

ENV PS1 "\n\n>> bashly \W \$ "
WORKDIR /app

RUN gem install bashly --version 0.6.8

ENTRYPOINT ["bashly"]