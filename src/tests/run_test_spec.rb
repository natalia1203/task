# frozen_string_literal: true
require 'rspec'
require 'selenium-webdriver'
require 'securerandom'

require_relative 'Pages/main_page'

describe 'yandex market test' do

  app = nil

  before(:each) do
    app = AbstractPage.new(Selenium::WebDriver.for(:chrome))
  end

  after(:each) do |reporting|
    if reporting.exception
      app.get_driver.save_screenshot(
        File.join(Dir.pwd, "results/#{SecureRandom.uuid}.png"))
    end
    app.quit

  end
  it 'searches for the first Samsung phone in mobile phones category and checks its title' do
    market_page = app.navigate_to_main_page
                     .navigate_to_market_page
                     .select_mobile_phones_category
                     .filter_items_by_brand
                     .filter_items_by_price(40_000)

    first_item_name = market_page .get_first_item_name
    first_item_name_on_details_page = market_page.navigate_to_first_item_details_page
                                                 .get_item_name
    expect(first_item_name_on_details_page).to eq first_item_name
  end

  it 'searches for beats headphones with price range between 17 and 25' do
    market_page = app.navigate_to_main_page
                     .navigate_to_market_page
                     .select_headphones_category
                     .filter_headphones_by_brand
                     .filter_by_price_range(17_000, 25_000)
    first_item_name = market_page .get_first_item_name
    first_item_name_details = market_page.navigate_to_first_item_details_page
                                         .get_item_name
    expect(first_item_name_details).to eq first_item_name
  end
end
