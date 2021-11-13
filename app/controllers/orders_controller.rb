class OrdersController < ApplicationController
  def create
    card = Card.find(params[:card_id])
    order = Order.create!(card: card, amount: card.price, state: 'pending', user: current_user)
    card.update(premium: false)
    #complete_image_path = "app/assets/images/#{card.image_path}"
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: card.title,
        #images: [complete_image_path],
        amount: card.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )
  
    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)

  end


  def show
      @order = current_user.orders.find(params[:id])
  end

  # def complete_order
  #   @order =Order.find(params[:order_id])
  #   @order.card.update(premium: false)
  #   @order.save!
  # end
    
end
