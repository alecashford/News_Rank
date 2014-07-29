require 'spec_helper'

describe FeedsController do

  describe "#destroy" do
    let(:user) {FactoryGirl.create(:user)}
    let(:feed) {FactoryGirl.create(:feed)}

      it "should destroy the subscription in the db" do
        subscription = Subscription.create(user: user, feed_id: feed.id)
        expect{delete :destroy, id: subscription_id}.to change(Subscription.count).by(-1)
      end

      it "should not delete the feed object"
      it "should redirect the user to the manage_feeds page?"

    end

  # describe '#index' do
  #   it "should set a @questions variable that corresponds to all questions" do
  #     get :index
  #     expect( assigns(:questions) ).to eq(Question.all)
  #   end

  #   it "should set a @question variable that corresponds to a Question object" do
  #     get :index
  #     expect( assigns(:question) ).to be_a(Question)
  #   end
  # end

  # describe '#show' do
  #   it "should set a @question variable that corresponds to the specified question" do
  #     question = FactoryGirl.create(:question)
  #     get :show, { id: question.id }
  #     expect( assigns(:question) ).to eq(question)
  #   end

  #   it "should set a @answer variable that corresponds to an Answer object" do
  #     question = FactoryGirl.create(:question)
  #     get :show, { id: question.id }
  #     expect( assigns(:answer) ).to be_an(Answer)
  #   end
  # end

  # describe "#create" do
  #   let(:question_params) { FactoryGirl.attributes_for(:question) }

  #   it "should create a new question" do
  #     expect{
  #       post :create, question: question_params
  #     }.to change{Question.count}.by(1)
  #   end

  #   it "should return a json string that corresponds to the associated post" do
  #     post :create, question: question_params
  #     expect(response).to render_template(:partial => '_component')
  #   end
  # end

  # describe '#destroy' do
  #   let(:question) { FactoryGirl.create(:question) }

  #   it "should remove the specified question from the database" do
  #     question
  #     expect{delete :destroy, id: question.id}.to change{Question.count}.by(-1)
  #   end

  #   it "should redirect the user to the question_index page" do
  #     delete :destroy, id: question.id
  #     expect(response).to redirect_to(questions_path)
  #   end
  # end

  # describe '#edit' do
  #   it "should set a @question variable that corresponds to the specified question" do
  #     question = FactoryGirl.create(:question)
  #     get :edit, { id: question.id }
  #     expect( assigns(:question) ).to eq(question)
  #   end
  # end

  # describe '#update' do
  #   let(:question) { FactoryGirl.create(:question) }
  #   let(:new_question_attributes) { FactoryGirl.attributes_for(:question) }

  #   it "updates the specified question with new parameters" do
  #     put :update, { id: question.id, question: new_question_attributes }
  #     question.reload
  #     expect(question.title).to eq(new_question_attributes[:title])
  #   end

  #   it "redirects the user to the specified question show page" do
  #     put :update, { id: question.id, question: new_question_attributes }
  #     expect(response).to redirect_to(question)
  #   end
  # end
end