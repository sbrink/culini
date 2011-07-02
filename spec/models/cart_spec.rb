require 'spec_helper'

describe Cart do
  before(:each) do
    @cart = Factory(:cart)
  end

  it { should have_many(:cart_articles) }
  it { should belong_to(:store) }
end
