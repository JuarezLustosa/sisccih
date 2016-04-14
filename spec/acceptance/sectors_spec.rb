require 'rails_helper'

feature "Create sectors", %q{
  As a person
  I want to create sectors
  To define sectors
} do

  let(:user) { create(:user)}
  let(:sector) { create(:sector)}
  let(:sector_uti) { create(:sector, name: "Uti")}

  background do
    login_as(user, :scope => :user)
  end

  scenario "register a new sector" do
    visit root_path

    click_link "Cadastros Básicos"
    click_link "Serviços"

    expect(page).to have_content "Lista de todos os serviços registrados"

    click_link "Cadastrar serviços"

    fill_in "Nome", :with => "Pediatria"

    click_button "Salvar"

    expect(page).to have_content "Serviço criado com sucesso."
    within_table('sectors') do
      expect(page).to have_content "Pediatria"
    end
  end

  scenario "edit a sector" do
    sector
    visit sectors_path

    within_table('sectors') do
      expect(page).to have_content "Pediatria"
    end
    expect(page).to have_content "Lista de todos os serviços registrados"

    click_link "Editar"

    fill_in "Nome", :with => "Ortopedia"

    click_button "Salvar"

    expect(page).to have_content "Serviço foi atualizado com sucesso."

    within_table('sectors') do
      expect(page).to have_content "Ortopedia"
    end
  end

  scenario "delete a sector" do
    sector
    visit sectors_path

    within_table('sectors') do
      expect(page).to have_content "Pediatria"
    end

    click_link "Apagar"
    dialog_accept

    expect(page).to have_content "Serviço foi removido com sucesso."
  end

  scenario "search by name or id" do
    sector
    sector_uti

    visit sectors_path

    fill_in "q_name_or_id_cont", :with => "Uti"
    click_button "Pesquisar"

    within_table('sectors') do
      expect(page).not_to have_content "Pediatria"
    end

    fill_in "q_name_or_id_cont", :with => "#{sector.id}"
    click_button "Pesquisar"

    within_table('sectors') do
      expect(page).to have_content "Pediatria"
    end
  end
end