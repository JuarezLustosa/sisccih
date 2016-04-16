require 'rails_helper'

feature "Materials", %q{
  As a nurse
  I want to create materials
  For I can use to define cirugies and precedures
} do

  let(:user) { create(:user)}
  let(:material) { create(:material)}
  let(:material_bisturi) { create(:material, description: "Bisturi")}

  background do
    login_as(user, :scope => :user)
  end

  scenario "register a new material" do
    visit root_path

    click_link "Cadastros Básicos"
    click_link "Material"

    expect(page).to have_content "Lista de todos os materiais registrados"

    click_link "Cadastrar materiais"

    fill_in "Descrição", :with => "Gase"

    click_button "Salvar"

    expect(page).to have_content "Material criado com sucesso."
    within_table('materials') do
      expect(page).to have_content "Gase"
    end
  end

  scenario "edit a material" do
    material
    visit materials_path

    within_table('materials') do
      expect(page).to have_content "Gase"
    end
    expect(page).to have_content "Lista de todos os materiais registrados"

    click_link "Editar"

    fill_in "Descrição", :with => "Bisturi"

    click_button "Salvar"

    expect(page).to have_content "Material foi atualizado com sucesso."

    within_table('materials') do
      expect(page).to have_content "Bisturi"
    end
  end

  scenario "delete a material" do
    material
    visit materials_path

    within_table('materials') do
      expect(page).to have_content "Gase"
    end

    click_link "Apagar"
    dialog_accept

    expect(page).to have_content "Material foi removido com sucesso."
  end

  scenario "search by name or id" do
    material
    material_bisturi

    visit materials_path

    fill_in "q_description_or_id_cont", :with => "Bisturi"
    click_button "Pesquisar"

    within_table('materials') do
      expect(page).not_to have_content "Gase"
    end

    fill_in "q_description_or_id_cont", :with => "#{material.id}"
    click_button "Pesquisar"

    within_table('materials') do
      expect(page).to have_content "Gase"
    end
  end
end