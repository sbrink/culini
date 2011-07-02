require 'spec_helper'

describe Category do
  before(:each) do
    @category = Factory(:category)
  end

  it { should allow_mass_assignment_of(:name) }
  it { should validate_presence_of(:name) }
  
  it { should have_many(:articles) }
  it { should have_many(:extras) }
  it { should belong_to(:store) }
end
