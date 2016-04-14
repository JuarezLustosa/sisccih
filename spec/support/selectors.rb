module Selectors
  Capybara.add_selector(:href) do
    xpath {|href| ".//a[@href='#{href}']"}
  end
end

#find(:linkhref, some_path).click