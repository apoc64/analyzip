class UserPresenter < Presenter
  def_delegator :@user, :user_zips

  def initialize(current_user)
    set_user(current_user)
  end

end
