require 'spec_helper'

describe "Static Pages" do

  describe "Home Page" do

    it "should have the content 'Sample App'" do
      visit root_path
      expect(page).to have_title('Home')
    end
  end

  describe "Help Page" do

    it 'should have the content "Help"' do
      visit help_path
      expect(page).to have_title('Help')
    end
  end

  describe "About Page" do
    
    it 'should have the content "About Us"' do
      visit about_path
      expect(page).to have_title('About Us')
    end
  end

  describe "Contact Page" do
  
    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_title("Contact")
    end
  end
end
