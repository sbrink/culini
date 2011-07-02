require 'spec_helper'

describe Extra do
  before(:each) do
    @extra = Factory(:extra)
  end

  it { should allow_mass_assignment_of(:name) }
  it { should validate_presence_of(:name) }
  
  it { should have_many(:cart_extras) }
  it { should belong_to(:category) }
end
