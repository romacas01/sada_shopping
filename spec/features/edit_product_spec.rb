require 'spec_helper'

describe "Editing a product details" do 
	it "fills the forms with the products details" do
      product = Product.create(product_details)

      visit product_url(product)

      click_link "Edit"

      expect(current_path).to eq(edit_product_path(product))
      expect(find_field('Name').value).to eq(product.name)
      expect(find_field('Description').value).to eq(product.description)

      fill_in 'Name', with: "New folding chair"

      click_button 'Update Product'

      expect(current_path).to eq(product_path(product))

      expect(page).to have_text("New folding chair")

	end	
end
