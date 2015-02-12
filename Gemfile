source 'https://rubygems.org'


group :default do
  gem 'rails', '4.1.6'
  gem 'sass-rails', '~> 4.0.3'
  gem 'uglifier', '>= 1.3.0'
  gem 'jbuilder', '~> 2.0'

  # exifr
  # 1. clone github.com/remvee/exifr to plugins/
  # 2. edit pluins/exifr/lib/exifr/tiff.rb
  #     before:
  #         0xa420 => :image_unique_id
  #       },
  #     after:
  #         0xa420 => :image_unique_id,
  #         0xa433 => :lens_make,
  #         0xa434 => :lens_model
  #       },
  # 3. bundle install
  gem 'exifr', path: 'plugins/exifr'

  gem 'kaminari'

  gem 'chartkick'
end

group :test, :development do
  gem 'sqlite3'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'guard-rspec'
  gem 'guard-spring'

  gem 'better_errors'

  gem 'bullet'

  gem 'rubocop'
  gem 'guard-rubocop'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'autodoc'

  gem 'capybara'
end

group :production do
  gem 'pg'
end
