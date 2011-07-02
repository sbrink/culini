require 'spec_helper'

describe CartArticle do
  before(:each) do
    @cart_article = Factory(:cart_article)
  end

  it { should have_many(:cart_extras) }
  it { should belong_to(:article) }
  it { should belong_to(:cart) }
end
