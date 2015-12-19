class WebsocketGameController < WebsocketRails::BaseController  
  # Demo Event
  def handle_hello
  	WebsocketRails[:updates].trigger(:update, "hello from the server. i received the message "+message)
  end

  # Start New Round - provide phrase to users
  def start_new_round
  	WebsocketRails[:updates].trigger(:new_round, get_random_phrase)
  end

  private
  def get_random_phrase
  	phrases = [
  		'There\'s an old phrase from Denmark. "She who punches cats..."', 
  		'There\'s an old phrase from Italy. "He who punches ferrets..."', 
  	]
  	phrases.sample
  end
end 