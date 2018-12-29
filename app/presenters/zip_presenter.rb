class ZipPresenter < Presenter
  def_delegator :@zip, :state
  def_delegator :@zip, :code

  attr_reader :zip,
              :fav_submit_message,
              :basic_irs_card

  def initialize(zip_code, current_user)
    @zip = Zip.find(zip_code)
    set_user(current_user)
    @basic_irs_card = irs_card_presenter
    set_location(zip.code)
  end

  def state_name
    @zip.state.name || @zip.state.abbreviation
  end

  def favorite
    if @user.user_zips.exists?(zip_id: zip.id)
      @fav_submit_message = 'Remove from my favorites'
      @user.user_zips.find_by(zip_id: zip.id)
    else
      @fav_submit_message = 'Add to my favorites'
      @user.user_zips.new
    end
  end

  private

  def irs_card_presenter
    cp = CardPresenter.new('Basic IRS Data')
    cp.set_collection(basic_irs_data(@zip))
  end
end
