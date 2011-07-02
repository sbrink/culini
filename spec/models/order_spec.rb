require 'spec_helper'

describe Order do
  before(:each) do
    @order = Factory(:order)
  end

  it { should allow_mass_assignment_of(:company) }
  it { should allow_mass_assignment_of(:department) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:street) }
  it { should allow_mass_assignment_of(:postcode) }
  it { should allow_mass_assignment_of(:city) }
  it { should allow_mass_assignment_of(:address_details) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:city) }
  it { should allow_mass_assignment_of(:phone_area_code) }
  it { should allow_mass_assignment_of(:phone_local_number) }
  it { should allow_mass_assignment_of(:special_instructions) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:postcode) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:phone_area_code) }
  it { should validate_presence_of(:phone_local_number) }

  it { should have_many(:order_articles) }
  it { should belong_to(:store) }

  it "should not save with an empty cart" do
    
  end

end