require 'rails_helper'

feature 'products' do
  
  context 'no products have been added' do
    scenario 'should display a prompt to add a product' do
      visit '/products'
      expect(page).to have_content 'No products added'
      expect(page).to have_link 'New product'
    end
  end

  context 'products have been added' do
	  before do
	    Product.create(title: 'cycle', description: 'good one', 
	    							image_url: 'image.jpg', price: 100)
	  end

	  scenario 'display products' do
	    visit '/products'
	    expect(page).to have_content('cycle' && 'good one')
	    expect(page).not_to have_content('No products added')
	  end
	end

	context 'raising errors when creating products' do
	  scenario 'prompts user to fill out a form, then displays the new product' do
	    visit '/products'
	    click_link 'New product'
	    fill_in 'Title', with: '' #title cant be blank
	    fill_in 'Description', with: '' #description can't be blank
	    fill_in 'Image url', with: 'image' #invalid url
	    fill_in 'Price', with: 0 #invalid quantity
	    click_button 'Create Product'
	    expect(page).to have_content '4 errors prohibited this product from being saved:
'
	  end
	end

	context 'creating products successfully' do
	  scenario 'prompts user to fill out a form, then displays the new product' do
	    visit '/products'
	    click_link 'New product'
	    fill_in 'Title', with: 'product title2'
	    fill_in 'Description', with: 'product description'
	    fill_in 'Image url', with: 'image.jpg'
	    fill_in 'Price', with: 10
	    click_button 'Create Product'
	    expect(page).to have_content 'Product was successfully created'
	  end
	end
end