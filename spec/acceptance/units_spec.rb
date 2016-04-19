require 'rails_helper'

feature "Units", %q{
  As a nurse
  I want to create units
  For I can know wich units the pacients were be hospitalizaded
} do

  let(:user) { create(:user)}
  let(:unit) { create(:unit)}
  let(:unit_hospital) { create(:unit, description: "Hospital")}

  background do
    login_as(user, :scope => :user)
  end

  scenario "register a new unit" do
    visit root_path

    click_link "Cadastros Básicos"
    click_link "Unidades"

    expect(page).to have_content "Lista de todas as unidades registradas"

    click_link "Cadastrar unidades"

    fill_in "Descrição", :with => "Pediatria"

    click_button "Salvar"

    expect(page).to have_content "Unidade criado(a) com sucesso."
    within_table('units') do
      expect(page).to have_content "Pediatria"
    end
  end

  scenario "edit a unit" do
    unit
    visit units_path

    within_table('units') do
      expect(page).to have_content "Fisioterapia"
    end
    expect(page).to have_content "Lista de todas as unidades registradas"

    click_link "Editar"

    fill_in "Descrição", :with => "Hospital"

    click_button "Salvar"

    expect(page).to have_content "Unidade foi atualizado(a) com sucesso."

    within_table('units') do
      expect(page).to have_content "Hospital"
    end
  end

  scenario "delete a unit" do
    unit
    visit units_path

    within_table('units') do
      expect(page).to have_content "Fisioterapia"
    end

    click_link "Apagar"
    dialog_accept

    expect(page).to have_content "Unidade foi removido(a) com sucesso."
  end

  scenario "search by description or id" do
    unit
    unit_hospital

    visit units_path

    fill_in "q_description_or_id_cont", :with => "Fisioterapia"
    click_button "Pesquisar"

    within_table('units') do
      expect(page).not_to have_content "Hospital"
    end

    fill_in "q_description_or_id_cont", :with => "#{unit.id}"
    click_button "Pesquisar"

    within_table('units') do
      expect(page).to have_content "Fisioterapia"
    end
  end
end