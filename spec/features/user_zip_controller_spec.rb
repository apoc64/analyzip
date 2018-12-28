require 'rails_helper'

describe 'User zip CRUD', type: :request do
  it 'can create a user zip' do
    user = User.create(first_name: 'bob', last_name: 'bobber', email: 'bob@bob.bob')
    zip = create(:zip)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(UserZip.count).to eq(0)
    expect(user.zips.count).to eq(0)

    post(user_zips_path, params: {user_zip: {zip_id: zip.id, comment: 'Cool zip', id: user.id}})

    expect(UserZip.count).to eq(1)
    expect(user.zips.count).to eq(1)
    expect(user.user_zips.count).to eq(1)
    expect(user.zips.first.id).to eq(zip.id)
    expect(user.user_zips.first.comment).to eq('Cool zip')
  end

  it 'can delete a user zip' do
    user = User.create(first_name: 'bob', last_name: 'bobber', email: 'bob@bob.bob')
    zip = create(:zip)
    user.zips << zip
    user_zip = user.user_zips.first
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(UserZip.count).to eq(1)
    expect(user.zips.count).to eq(1)

    delete(user_zip_path(user_zip))

    expect(UserZip.count).to eq(0)
    expect(user.zips.count).to eq(0)
    expect(user.user_zips.count).to eq(0)
  end

  it 'can update a user zip' do
    user = User.create(first_name: 'bob', last_name: 'bobber', email: 'bob@bob.bob')
    zip = create(:zip)
    user_zip = user.user_zips.create(zip: zip, comment: 'Cool Zip')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(UserZip.count).to eq(1)
    expect(user.zips.count).to eq(1)
    expect(user.user_zips.count).to eq(1)
    expect(user_zip.comment).to eq('Cool Zip')

    patch("/user_zips/#{user_zip.id}", params: {user_zip: {zip_id: zip.id, comment: 'Wow!', id: user.id}})

    expect(UserZip.count).to eq(1)
    expect(user.zips.count).to eq(1)
    expect(user.user_zips.count).to eq(1)
    expect(UserZip.first.comment).to eq('Wow!')
    expect(UserZip.first.user).to eq(user)
    expect(UserZip.first.zip).to eq(zip)
  end

end
