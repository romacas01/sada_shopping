require 'spec_helper'

describe "Deleting a product" do 
  it "removes the product from the database" do 
    product = Product.create(product_details)

    visit product_url(product)

    click_link "Delete product"

    expect(current_path).to eq(products_path)
    expect(page).not_to have_text(product.name)
    expect(page).to have_text("Product successfully deleted!")
  end	
end	