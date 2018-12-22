require 'rails_helper'

describe 'zip presenter favorites' do
  it 'returns a blank user_zip if none exists' do
    user = User.create(first_name: 'bob', last_name: 'bobber', email: 'bob@bob.bob')
    zip = create(:zip)
    allow_any_instance_of(Google).to receive(:center).and_return({"lat" => 0, "lng" => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({"northeast" => {"lat" => 0, "lng" => 0}, "southwest" => {"lat" => 0, "lng" => 0}})

    presenter = ZipPresenter.new(zip.id, user)

    expect(presenter.code).to eq(zip.code)
    favorite = presenter.favorite
    expect(favorite).to be_a(UserZip)
    expect(favorite.persisted?).to eq(false)
    expect(presenter.fav_submit_message).to eq("Add to my favorites")
    expect(favorite.comment).to eq(nil)
  end

  it 'returns the favorited zip and comment' do
    user = User.create(first_name: 'bob', last_name: 'bobber', email: 'bob@bob.bob')
    zip = create(:zip)
    user.user_zips.create(zip: zip, comment: "Cool Zip")
    allow_any_instance_of(Google).to receive(:center).and_return({"lat" => 0, "lng" => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({"northeast" => {"lat" => 0, "lng" => 0}, "southwest" => {"lat" => 0, "lng" => 0}})

    presenter = ZipPresenter.new(zip.id, user)

    expect(presenter.code).to eq(zip.code)
    favorite = presenter.favorite
    expect(favorite).to be_a(UserZip)
    expect(favorite.persisted?).to eq(true)
    expect(presenter.fav_submit_message).to eq("Remove from my favorites")
    expect(favorite.comment).to eq("Cool Zip")
  end
end
