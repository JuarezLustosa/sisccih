module Dialog
  module Accept
    def dialog_accept
      dialog = page.driver.browser.switch_to.alert
      dialog.accept
    end
  end
end