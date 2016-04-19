require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { Unit.new(description: "Fisioterapia") }
  let(:unit_saved) { create(:unit)}

  it "presence of name" do
    expect(unit).to be_valid
    unit.description = nil
    expect(unit).to be_invalid
    expect_error_on unit, method: :description
  end

  it "uniqueness of presence" do
    unit.description = unit_saved.description
    expect(unit).to be_invalid
    expect_error_on unit, method: :description
  end
end
