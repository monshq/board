require 'spec_helper'

describe UsersAuthorizer do

  before :each do
    @user = FactoryGirl.create :user
    @user.grant :user

    @admin = FactoryGirl.create :user
    @admin.grant :admin

    @guest = FactoryGirl.create :user
  end

  describe "class" do
    it 'Admin can create any user' do
      expect(UsersAuthorizer).to be_creatable_by(@admin)
    end

    it 'User can not create users' do
      expect(UsersAuthorizer).not_to be_creatable_by(@user)
    end

    it 'Guest cat not create users' do
      expect(UsersAuthorizer).not_to be_creatable_by(@guest)
    end

    it 'Admin can get info of every user' do
      expect(UsersAuthorizer).to be_readable_by(@admin)
    end

    it 'User can get info of every user' do
      expect(UsersAuthorizer).to be_readable_by(@user)
    end

    it 'Guest can not get users info' do
      expect(UsersAuthorizer).not_to be_readable_by(@guest)
    end

    it 'Admin can not delete users' do
      expect(UsersAuthorizer).not_to be_deletable_by(@admin)
    end

    it 'User can not delete users' do
      expect(UsersAuthorizer).not_to be_deletable_by(@user)
    end
  end

  describe "instances" do
    before :each do
      @test_user_instance = FactoryGirl.create :user
    end

    it 'Admin can get current user info' do
      expect(@test_user_instance.authorizer).to be_readable_by(@admin)
    end

    it 'User can get current user info' do
      expect(@test_user_instance.authorizer).to be_readable_by(@user)
    end

    it 'Guest can not get current user info' do
      expect(@test_user_instance.authorizer).not_to be_readable_by(@guest)
    end

    it 'Admin can become current user' do
      expect(@test_user_instance.authorizer).to be_becomable_by(@admin)
    end

    it 'Admin can not become user if user is admin' do
      test_admin_user = FactoryGirl.create :user
      test_admin_user.grant :admin
      expect(test_admin_user).not_to be_becomable_by(@admin)
    end

    it 'User can not become another user' do
      expect(@test_user_instance.authorizer).not_to be_becomable_by(@user)
    end

    it 'Guest can not become user' do
      expect(@test_user_instance.authorizer).not_to be_becomable_by(@guest)
    end

    it 'Admin can create current user' do
      expect(@test_user_instance.authorizer).to be_creatable_by(@admin)
    end

    it 'User can not create current user' do
      expect(@test_user_instance.authorizer).not_to be_creatable_by(@user)
    end

  end
end
