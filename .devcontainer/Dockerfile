FROM mcr.microsoft.com/devcontainers/ruby:0-3-bullseye

# コンテナ内でプロキシを設定
ARG http_proxy
ARG https_proxy
ARG no_proxy
ENV http_proxy=$http_proxy https_proxy=$https_proxy no_proxy=$no_proxy

# Install Rails
RUN gem install rails webdrivers

# Default value to allow debug server to serve content over GitHub Codespace's port forwarding service
# The value is a comma-separated list of allowed domains
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev,.preview.app.github.dev,.app.github.dev"

# [Optional] Uncomment this section to install additional OS packages.
# 必要なパッケージのインストール
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive &&
#     apt-get -y install --no-install-recommends \
#         build-essential \
#         libsqlite3-dev \
#         sqlite3 \
#         nodejs \
#         yarn

# [Optional] Uncomment this line to install additional gems.
RUN gem install \
    # debug
    rdbg \
    # test
    rspec-rails \
    # formatter
    rufo \
    # linter
    standard \
    # docment generator
    yard \
    # language server
    solargraph

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

# 作業ディレクトリの設定
# WORKDIR /app

# ポートの公開
# EXPOSE 3000

# コンテナ起動時に実行されるコマンド
# CMD ["rails", "server", "--binding", "0.0.0.0"]
