require 'spec_helper'

describe ArticlesController do
  describe "#get_all_articles" do
    test_user = User.create(email: "britney@gmail.com", password:"123456789")
    current_user = test_user

    # it "creates a new answer" do
    #   expect{
    #     post :create, question_id: question.id, answer: answer_params
    #   }.to change{Answer.count}.by(1)
    # end

    # it "returns a JSON-formatted string that corresponds to the specified answer" do
    #   post :create, question_id: question.id, answer: answer_params
    #   expect(response.body).to eq(Answer.last.to_json(:methods => :score))
    # end
  end
end