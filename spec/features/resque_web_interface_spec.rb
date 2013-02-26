# encoding: UTF-8

require 'spec_helper'

feature 'Resque web interface' do
  scenario 'Must be use HTTP basic auth' do
    visit resque_server_path
    page.status_code.should eq 401
  end

  scenario "Must accept 'test/test'" do
    page.driver.browser.authorize 'test', 'test'
    visit resque_server_path
    page.status_code.should eq 200
  end
end