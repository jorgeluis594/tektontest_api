class InvoicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |e|
    send_error(e.message, :not_found)
  end

  rescue_from NoMethodError do |e|
    send_error("Products can't be blank", :unprocessable_entity)
  end

  def index
    @invoices = Invoice.all
    send_success(@invoices)
  end

  def show
    @invoice = Invoice.find(params['id'])
    send_success(@invoice)
  end

  def create
    params = get_params
    products = get_products(params['products'])
    @invoice = Invoice.create!(client: params['client'], ruc: params['ruc'])

    products.each { |product| @invoice.invoice_items.create!(product_id: product[:product_id], quantity: product[:product_quantity] ) }

    send_success({
                     id: @invoice.id,
                     client: @invoice.client,
                     ruc: @invoice.ruc,
                     products: products
                 }, :created)
  end

  private

  def get_params
    params.require(:invoice)
  end

  def get_products(products)
      raise NoMethodError if products.blank? || products.nil?
      products.map do |product|
        item = Product.find(product['id'])
        {
            product_id: item['id'],
            product_name: item['name'],
            product_price: item['price'],
            product_quantity: product['quantity'],
            product_currency_type: item['currency_type'],
            product_total_price: "#{(item['price']*product['quantity'].to_i)} #{item['currency_type']}"
        }
      end
  end
end
