class UserPresenter
  extend Forwardable
  def_delegator :@user, :first_name

  attr_reader :user

  def initialize(user_id)
    @user = User.find(user_id)
  end
end
