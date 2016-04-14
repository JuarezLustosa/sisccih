require 'rails_helper'

RSpec.describe Sector, type: :model do
  let(:sector) { Sector.new(name: "Ortopedia") }
  let(:sector_saved) { create(:sector)}

  it "presence of name" do
    expect(sector).to be_valid
    sector.name = nil
    expect(sector).to be_invalid
    expect_error_on sector, method: :name
  end

  it "uniqueness of presence" do
    sector.name = sector_saved.name
    expect(sector).to be_invalid
    expect_error_on sector, method: :name
  end
end
