class Partner

  attr_accessor :order, :state, :country, :title

  def initialize(order, state, country, title)
    @order = order
    @state = state
    @country = country
    @title = title
  end

  def partner_information
    {
      name: order.name,
      street: order.ship_address.address1,
      city: order.ship_address.city,
      state_id: state.id,
      zip: order.ship_address.zipcode,
      country_id: country.id,
      phone: order.ship_address.phone,
      email: order.email,
      function: "Not Defined `" + order.number,
      title_id: title.id
    }
  end

end
