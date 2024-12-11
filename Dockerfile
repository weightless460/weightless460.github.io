# 使用指定版本的基础镜像
FROM jekyll/jekyll:4.2.2

LABEL MAINTAINER="Amir Pourmand"

# 安装 imagemagick
RUN apk add --no-cache imagemagick-dev imagemagick

# 设置工作目录
WORKDIR /srv/jekyll

# 添加 Gemfile 并安装依赖
ADD Gemfile /srv/jekyll/
RUN bundle install --clean
