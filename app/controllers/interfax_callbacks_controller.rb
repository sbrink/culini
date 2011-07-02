class InterfaxCallbacksController < Devise::OmniauthCallbacksController

  def interfax_callback
    Order.process_interfax_callback!(params["TransactionID"],params["Status"])
    render :text => "OK"
  end

end
