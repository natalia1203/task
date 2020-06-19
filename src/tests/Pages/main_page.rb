require_relative 'abstract_page'
require_relative 'market_page'

class MainPage < AbstractPage

  def initialize(driver)
    super(driver)
  end

  MARKET_PAGE_LINK = "//a[@data-id='market']".freeze

  def navigate_to_market_page
    @@driver.find_element(:xpath, MARKET_PAGE_LINK).click
    @@driver.switch_to.window(@@driver.window_handles[1])
    return MarketPage.new(@@driver)
  end
end
