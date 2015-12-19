class WebsocketGameController < WebsocketRails::BaseController  
  # Demo Event
  def handle_hello
  	WebsocketRails[:updates].trigger(:update, "hello from the server")
  end

  # Start New Round - provide phrase to users
  def start_new_round
  	WebsocketRails[:updates].trigger(:update, "???")
  end
end 