require_relative 'abstract_page'

class ItemPage < AbstractPage
  def initialize(driver)
    super(driver)
  end

  ITEM_NAME = '//ul/../div/h1'.freeze

  def get_item_name
    @@driver.find_element(:xpath, ITEM_NAME).text
  end
end
