require 'spec_helper'

describe ArticlesController do
  describe "#index" do
    let(:user) { FactoryGirl.create :user }
    it "returns a JSON that corresponds to the users articles" do
      controller.stub(:current_user) { user }
      expect(controller.current_user).to receive(:articles)
      get :index
      expect(response.header["Content-Type"]).to include "application/json"
    end
  end
end