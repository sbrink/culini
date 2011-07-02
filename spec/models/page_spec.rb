require 'spec_helper'

describe Page do
  before(:each) do
    @page = Factory(:page)
  end
  
  it { should allow_mass_assignment_of(:name) }
  it { should validate_presence_of(:name) }

  it { should allow_mass_assignment_of(:body) }
  it { should validate_presence_of(:body) }

  it { should allow_mass_assignment_of(:permalink) }
  it { should validate_presence_of(:permalink) }
  it { should validate_uniqueness_of(:permalink) }
  
  it "should have the permalink as param" do
    @page.to_param.should == @page.permalink
  end
end
