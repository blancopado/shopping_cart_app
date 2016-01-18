require 'rails_helper'

feature 'store' do
  
  context 'show a list of products' do
    
  	before do
	    Product.create(title: 'product_name', description: 'product description', 
	    							image_url: 'image.jpg', price: 10)
	  end

    scenario 'should display a list of products' do
      visit '/'
      expect(page).to have_content 'product_name' && 'product description'
      expect(page).to have_content '£10.00'
    end
  end

end