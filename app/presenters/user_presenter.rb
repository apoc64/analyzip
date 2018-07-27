class UserPresenter < Presenter
  # include Presenter
  # extend Forwardable
  # def_delegator :@user, :first_name
  # def_delegator :@user, :log_action
  # def_delegator :@user, :log_path
  #
  # attr_reader :user

  def initialize(current_user)
    # in presenter module:???
    set_user(current_user)
  end

  # def set_user(current_user)
  #   page_user = current_user || User.new
  #   @user = UserDecorator.new(page_user)
  # end
end
