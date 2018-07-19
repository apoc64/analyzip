class ZipPresenter
  extend Forwardable
  def_delegator :@zip, :n1
  def_delegator :@zip, :percent_single
  def_delegator :@zip, :percent_joint
  def_delegator :@zip, :percent_hoh
  def_delegator :@zip, :percent_paid_prep
  def_delegator :@zip, :percent_elderly
  def_delegator :@zip, :mean_income
  def_delegator :@zip, :state

  attr_reader :code,
              :zip,
              :lat,
              :lng

  def initialize(zip_code)
    @code = zip_code
    @zip = Zip.find(zip_code)
    coords = Google.new.zip_coords(zip_code)
    @lat = coords["lat"]
    @lng = coords["lng"]
  end

  def state_name
    @zip.state.name || @zip.state.abbreviation
  end

  def average_dependents
    @zip.average_dependents.round(2)
  end


end
