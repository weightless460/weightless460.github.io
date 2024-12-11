FROM jekyll/jekyll
LABEL MAINTAINER="Amir Pourmand"

# 安装必要的系统依赖
RUN apk add --no-cache --virtual .build-deps \
        libxml2-dev \
        shadow \
        autoconf \
        g++ \
        make \
    && apk add --no-cache imagemagick-dev imagemagick

# 设置工作目录
WORKDIR /srv/jekyll

# 复制 Gemfile
COPY Gemfile /srv/jekyll/
COPY Gemfile.lock /srv/jekyll/

# 安装 Bundler 和 Gem 包
RUN gem install bundler && bundle install

# 复制项目文件
COPY . /srv/jekyll

# 暴露 Jekyll 默认端口
EXPOSE 8080

# 启动命令
CMD ["bash", "-c", "rm -f Gemfile.lock && bundler exec jekyll serve --watch --port=8080 --host=0.0.0.0 --livereload --verbose"]
