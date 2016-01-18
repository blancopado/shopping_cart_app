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
	    Product.create(title: 'product_name', description: 'product description', 
	    							image_url: 'image.jpg', price: 10)
	  end

	  scenario 'display products' do
	    visit '/products'
	    expect(page).to have_content('product_name' && 'product description')
	    expect(page).not_to have_content('No products added')
	  end
	end

	context 'show product details' do
	  before do
	    Product.create(title: 'product_name', description: 'product description', 
	    							image_url: 'image.jpg', price: 10)
	  end

	  scenario 'display products' do
	    visit '/products'
	    click_link 'Show'
	    expect(page).to have_content('product_name' && 'product description' && 'image.jpg' && 10)
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
	    expect(page).to have_content '4 errors prohibited this product from being saved'

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

	context 'updating and deleting products' do
	  
	  before do
	    Product.create(title: 'product_name', description: 'product description', 
	    							image_url: 'image.jpg', price: 10)
	  end

	  scenario 'click Update link and change product details' do
	    visit '/products'
	    click_link 'Edit'
	    fill_in 'Image url', with: 'image2.jpg'
	    fill_in 'Price', with: 20
	    click_button 'Update Product'
	    expect(page).to have_content('Product was successfully updated.')
	  end

	  scenario 'click Destroy link and remove the product' do
	    visit '/products'
	    click_link 'Destroy'
	    expect(page).to have_content('Product was successfully destroyed.')
	  end
	end
end

