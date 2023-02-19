ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
module SignInHelper
  def sign_in_as(user)
    user= User.find(user)
    post session_url(email: user.email, password: user.password)
  end
  # def even_number(number)
  #   assert( number % 2 == 0), "#{number} is not an even number"
  # end
end
class ActionDispatch::IntegrationTest
  include SignInHelper
end
