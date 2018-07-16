class AddressesController < ApplicationController
  def index
    @addresses = Address.all
    render 'new'
  end

  def new; end

  def create
    #validate the parameters
    @parameters = address_params
    @message = 'The address failed to save!'

    #if valid then save new address
    if @parameters[:valid]
      @address = Address.new(@parameters[:address])

      if @address.save
        @message = 'The address was saved successfully!'
      end
    end

    render 'new'
  end

  private

  def address_params
    #validate the parameters
    @parameters = params.permit(:city, :state, :street_address, :zip_code)
    Address.validateAddress(@parameters)
  end
end
