class SignIn < ActiveSupport::TestCase
    test "Failed signin" do
        session[:user_id] = nil
        assert require_signin
    end
    test "successful signin" do
        session[:user_id] = 1
        assert require_signin
    end
end