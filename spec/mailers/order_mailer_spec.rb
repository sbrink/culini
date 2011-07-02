require "spec_helper"

describe OrderMailer do
  before(:each) do
    @store = Factory(:store)
    @order = Factory(:order)
    @order.store = @store
  end
  
  describe "order_confirmation" do
    let(:mail) { OrderMailer.order_confirmation(@order) }

    it "renders the headers" do
      mail.subject.should eq("Order confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
