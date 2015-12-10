class ProductItemsController < ApplicationController

  before_action :create_cart, only: [:create]

  def create
      product = Product.find(params[:product])
        @product_item = @cart.add_product_item(product)
        respond_to do |format|
          if @product_item.save
            format.html { redirect_to products_path }
            format.js
          end
        end        
  end

  def update
    product_item = ProductItem.find(params[:product_item_id])
    product = Product.find(product_item.product_id)
    #if user selected a quantity higher than the stock the order will not be updated
    if params[:quantity].to_i <= product.quantity + product_item.quantity
      #returns the product amount from the cart to the catalogue
      product.quantity += product_item.quantity
      product.save
      #increases quantity in the cart
      product_item.update(quantity: params[:quantity])
      #decreases quantity in the catalogue
      params[:quantity].to_i.times do 
        product.quantity -= 1
        product.save
      end  
      redirect_to cart_url(product_item.cart_id)
    else
      #product_item.update(:quantity 0)
      redirect_to cart_url(product_item.cart), notice: "The quantity selected exceeds the stock quantity" 
    end   
  end  

  #private

  #def product_item_params
   # params.require(:product_item).permit(:product)
 # end 
end