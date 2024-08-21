FROM dannyben/alpine-ruby:3.3.3

ENV BASHLY_VERSION=1.2.2
ENV PS1="\n\n>> bashly \W \$ "
WORKDIR /app

# Install pandoc to support manpage generation (`bashly render :mandoc docs`)
RUN apk add --no-cache pandoc-cli

RUN gem install bashly --version $BASHLY_VERSION && \
    gem update --system

ENTRYPOINT ["bashly"]