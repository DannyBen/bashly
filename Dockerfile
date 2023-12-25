FROM dannyben/alpine-ruby

ENV PS1 "\n\n>> bashly \W \$ "
WORKDIR /app

# Install pandoc to support manpage generation (`bashly render :mandoc docs`)
RUN apk add --no-cache pandoc-cli

RUN gem install bashly --version 1.1.5

ENTRYPOINT ["bashly"]