FROM ruby:2.6.10

# Node.jsのバージョン14をインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

# Yarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn

# sudoのインストール
RUN apt-get update && apt-get install -y sudo

WORKDIR /thingumo

COPY Gemfile /thingumo/Gemfile
COPY Gemfile.lock /thingumo/Gemfile.lock

RUN bundle install
RUN apt-get update && apt-get install -y default-mysql-client

COPY . /thingumo

RUN bundle exec rails webpacker:install
RUN node -v

ENV PATH /usr/local/nodejs/bin:$PATH

CMD ["rails", "server", "-b", "0.0.0.0"]