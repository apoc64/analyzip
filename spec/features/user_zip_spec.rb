require 'rails_helper'

describe 'User zip CRUD', type: :request do
  it 'can create a user zip' do
    user = User.create(first_name: 'bob', last_name: 'bobber', email: 'bob@bob.bob')
    zip = create(:zip)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(UserZip.count).to eq(0)
    expect(user.zips.count).to eq(0)

    post(user_zips_path, params: {user_zip: {zip_id: zip.id, comment: "Cool zip", id: user.id}})

    expect(UserZip.count).to eq(1)
    expect(user.zips.count).to eq(1)
    expect(user.user_zips.count).to eq(1)
    expect(user.zips.first.id).to eq(zip.id)
    expect(user.user_zips.first.comment).to eq("Cool zip")
  end

end
