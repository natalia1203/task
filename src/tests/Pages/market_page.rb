require_relative 'abstract_page'
require_relative 'item_page'

class MarketPage < AbstractPage
  def initialize(driver)
    super(driver)
  end

  ELECTRONICS_LINK = "//div[@data-zone-name='category-link'][2]//a".freeze
  MOBILE_PHONES_LINK = "//a[contains(text(),'Мобильные телефоны')]".freeze
  HEADPHONES_LINK = "//a[contains(text(),'Наушники и Bluetooth-гарнитуры')]".freeze
  SAMSUNG_BRAND_CHECKBOX = "//span[contains(text(),'Samsung')]".freeze
  BEATS_BRAND_CHECKBOX = "//input[@name='Производитель Beats']/ancestor::label".freeze
  PRICE_FROM_FILTER = "//input[@id='glpricefrom']".freeze
  PRICE_TO_FILTER = "//input[@id='glpriceto']".freeze
  FIRST_ITEM_ON_CATEGORY_PAGE = "//article[1]//a/span".freeze
  HEADER_TITLE = "//div[@class='headline__header-title']//h1".freeze
  BRAND_FILTERS = "//div[@data-zone-name='search-filter']//legend[contains(text(), 'Производитель')]".freeze


  def select_mobile_phones_category
    @@driver.find_element(:xpath, ELECTRONICS_LINK).click
    wait_element_displayed(MOBILE_PHONES_LINK)
    @@driver.find_element(:xpath, MOBILE_PHONES_LINK).click
    wait 15
    return MarketPage.new(@@driver)
  end

  def select_headphones_category
    @@driver.find_element(:xpath, ELECTRONICS_LINK).click
    wait_element_displayed(HEADPHONES_LINK)
    @@driver.find_element(:xpath, HEADPHONES_LINK).click
    wait 20
    return MarketPage.new(@@driver)
  end

  def filter_items_by_brand
    wait_element_displayed(SAMSUNG_BRAND_CHECKBOX)
    wait 10
    @@driver.find_element(:xpath, SAMSUNG_BRAND_CHECKBOX).click
    wait_filtered_by_brand
    return MarketPage.new(@@driver)
  end

  def filter_headphones_by_brand
    @@driver.find_element(:xpath, BEATS_BRAND_CHECKBOX).click
    wait 20
    return MarketPage.new(@@driver)
  end

  def filter_by_price_range(from, to)
    @@driver.find_element(:xpath, PRICE_FROM_FILTER).send_keys(from)
    @@driver.find_element(:xpath, PRICE_TO_FILTER).send_keys(to)
    wait 20
    return MarketPage.new(@@driver)
  end

  def filter_items_by_price (price)
    @@driver.find_element(:xpath, PRICE_FROM_FILTER).send_keys(price)
    wait 20
    return MarketPage.new(@@driver)
  end

  def get_first_item_name
    return @@driver.find_element(:xpath, FIRST_ITEM_ON_CATEGORY_PAGE).text
  end

  def navigate_to_first_item_details_page
    @@driver.find_element(:xpath, FIRST_ITEM_ON_CATEGORY_PAGE).click
    @@driver.switch_to.window(@@driver.window_handles[2])
    return ItemPage.new(@@driver)
  end

    private

  def wait_element_displayed(locator)
    wait = Selenium::WebDriver::Wait.new(timeout: 20)
    wait.until { @@driver.find_element(:xpath, locator).displayed? }
  end

  def wait_filtered_by_brand
    wait = Selenium::WebDriver::Wait.new(timeout: 20)
    wait.until {@@driver.find_element(:xpath, HEADER_TITLE).text == 'Мобильные телефоны Samsung'}
  end

  def wait(duration)
    sleep(duration)
  end

  end


