# Sử dụng Ruby 2.7.8 image làm base
FROM ruby:2.7.8

# Cài đặt các dependencies
RUN apt-get update -qq && apt-get install -y nodejs sqlite3

# Set làm working directory trong container
WORKDIR /app

# Copy Gemfile và Gemfile.lock vào working directory
COPY Gemfile Gemfile.lock ./

# Cài đặt gems
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copy toàn bộ source code vào working directory
COPY . .

# Set environment variables
ENV RAILS_ENV=development

# Chạy lệnh tạo database và migrate
RUN rails db:create && rails db:migrate

# Expose cổng 3000 cho Rails server
EXPOSE 3000

# Chạy Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
