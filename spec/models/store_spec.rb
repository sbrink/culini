require 'spec_helper'

describe Store do
  before(:each) do
    @store = Factory(:store)
  end

  it { should allow_mass_assignment_of(:name) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:postcode) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:user_id) }
    
  it { should have_many(:categories) }
  it { should have_many(:carts) }
  it { should have_many(:orders) }
  it { should have_many(:store_hours) }
  it { should have_many(:delivery_zones) }
  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:tags) }
end
