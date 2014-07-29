describe SubscriptionController do

  describe "#destroy" do
    let(:user) {FactoryGirl.create(:user)}
    let(:feed) {FactoryGirl.create(:feed)}

      it "should destroy the subscription in the db" do
        subscription = Subscription.create(user: user, feed_id: feed.id)
        expect{delete :destroy, id: subscription_id}.to change(Subscription.count).by(-1)
      end

    end
