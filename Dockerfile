FROM ruby:3.3.0-slim-bookworm

ENV PS1 "\n\n>> bashly \W \$ "
WORKDIR /app

ENV BASHLY_VERSION=1.1.6
ENV RUBY_SYSTEM_VERSION=3.5.5

# Install pandoc to support manpage generation (`bashly render :mandoc docs`)
RUN apt update -y  \
    && apt install pandoc -y  \
    && apt clean

RUN gem install bashly --version $BASHLY_VERSION  \
    && gem update --system $RUBY_SYSTEM_VERSION

ENTRYPOINT ["bashly"]
