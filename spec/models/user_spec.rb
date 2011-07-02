require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory(:user)
  end

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }

  it { should validate_acceptance_of(:terms_of_service) }
  
  it { should have_many(:stores)}
end
