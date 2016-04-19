require 'rails_helper'

RSpec.describe Material, type: :model do
  let(:material) { Material.new(description: "Bisturi") }
  let(:material_saved) { create(:material)}

  it "presence of name" do
    expect(material).to be_valid
    material.description = nil
    expect(material).to be_invalid
    expect_error_on material, method: :description
  end

  it "uniqueness of presence" do
    material.description = material_saved.description
    expect(material).to be_invalid
    expect_error_on material, method: :description
  end
end
