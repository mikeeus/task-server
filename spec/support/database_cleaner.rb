# Installing database_cleaner:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Add database_cleaner to Gemfile:
#
# group :test do
#   gem 'database_cleaner'
# end

# 2. IMPORTANT! Delete the "config.use_transactional_fixtures = ..." line
#    in spec/rails_helper.rb (we're going to configure it in this file you're
#    reading instead).

# 3. Create a file like this one you're reading in spec/support/database_cleaner.rb:
RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion, except: %w(spatial_ref_sys))
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :deletion, { except: %w(spatial_ref_sys) }
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# Thoughtbot strategy
# RSpec.configure do |config|
#   config.before(:suite) do
#     DatabaseCleaner.clean_with(:truncation)
#   end

#   config.before(:each) do
#     DatabaseCleaner.strategy = :transaction
#   end

#   config.before(:each, js: true) do
#     DatabaseCleaner.strategy = :truncation
#   end

#   config.before(:each) do
#     DatabaseCleaner.start
#   end

#   config.after(:each) do
#     DatabaseCleaner.clean
#   end
# end