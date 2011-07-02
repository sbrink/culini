require 'spec_helper'

describe CartExtra do
  before(:each) do
    @cart_extra = Factory(:cart_extra)
  end

  it { should belong_to(:cart_article) }
  it { should belong_to(:extra) }
end
