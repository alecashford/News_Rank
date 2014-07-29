require 'spec_helper'

describe FeedsController do
  describe '#index' do
    let(:user) { FactoryGirl.create :user }
    it "should return a JSON that corresponds to the current users feeds" do
      controller.stub(:current_user) { user }
      expect(controller.current_user).to receive(:feeds)
      get :index
      expect(response.header["Content-Type"]).to include "application/json"
    end
  end

  describe '#create' do
    let(:user) { FactoryGirl.create :user }
    it "should create an association between the current user and a feed"

    it "should create a new feed if the feed doesn't exist in the database"
end

