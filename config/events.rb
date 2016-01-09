WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  #   subscribe :client_connected, :to => Controller, :with_method => :method_name
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.

  subscribe :hello, :to => WebsocketGameController, :with_method => :handle_hello
  subscribe :start_round, :to => WebsocketGameController, :with_method => :start_new_round
  subscribe :submit_phrase_ending, :to => WebsocketGameController, :with_method => :handle_phrase_submission
  subscribe :submit_vote, :to => WebsocketGameController, :with_method => :handle_vote_submission
  subscribe :new_player, :to => WebsocketGameController, :with_method => :handle_new_player
end
