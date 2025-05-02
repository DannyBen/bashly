FROM dannyben/alpine-ruby:3.3.3

LABEL io.whalebrew.name=bashly

ENV PS1="\n\n>> bashly \W \$ "
ENV BASHLY_VERSION=1.2.12

WORKDIR /app

# Install pandoc to support manpage generation (`bashly render :mandoc docs`)
RUN apk add --no-cache pandoc-cli

RUN gem install bashly --version $BASHLY_VERSION

VOLUME /app

ENTRYPOINT ["bashly"]
