require 'spec_helper'

describe Article do
  before(:each) do
    @article = Factory(:article)
  end

  it { should allow_mass_assignment_of(:name) }
  it { should validate_presence_of(:name) }
  
  it { should have_many(:cart_articles) }
  it { should belong_to(:category) }
end
