# frozen_string_literal: true
require 'rspec'
require 'selenium-webdriver'

require_relative 'main_page'

class AbstractPage
  @@driver = nil

  def initialize(driver)
    @@driver = driver
  end

  MAIN_PAGE = 'https://yandex.ru'

  def get_driver
    @@driver
  end

  def navigate_to_main_page
    @@driver.manage.window.maximize
    @@driver.navigate.to MAIN_PAGE
    return MainPage.new(@@driver)
  end

  def quit
    @@driver.quit
  end
end
