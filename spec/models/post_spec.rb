require 'rails_helper'

RSpec.describe Player,type: :model do

  describe "validations" do
    it "validate precence of required files" do
      should validate_presence_of(:name)
      should validate_presence_of(:level)
      should validate_presence_of(:goals)
      should validate_presence_of(:salary)
      should validate_presence_of(:bonus)
      should validate_presence_of(:team)
    end
  end

end
