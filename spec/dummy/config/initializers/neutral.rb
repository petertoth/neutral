#Neutral engine Initializer

Neutral.configure do |config|
  # Set to false wheter a voter cannot change(i.e. update or delete) his vote.
  #config.can_change = true

  # Configure method providing a voter instance.
  # Also make sure your current voter method is accessible from your ApplicationController
  # as a helper_method.
  #config.current_voter_method = :current_user

  # Determine wheter a voter is required to be logged in. Setting to false
  # is not recommended.
  #config.require_login = true

  # Define a vote owner class(usually User, Client, Customer)
  #config.vote_owner_class = 'User'

  # Define default icon set. Used when no explicit icon set for helper
  # 'voting_for' is passed.
  #config.default_icon_set = :thumbs
end

# You can also define your custom icon set providing valid FontAwesome icon class definitions for
# positive, negative and remove icon. You cannot override icon sets that already exist('thumbs' and 'operations' by default).
# Beware of typos and non-existent FontAwesome icon classes.
# Then you can used your own icon set by passing its name to the view helper : 'voting_for voteable, icons: :mysupericons'

# Neutral.define do
#   set :myicons do
#     positive "fa-plus-circle"
#     negative "fa-minus-circle"
#     remove   "fa-times"
#   end
#
#   set :mythumbs do
#     positive "fa-thumbs-up"
#     negative "fa-thumbs-down"
#     remove "fa-times"
#   end
# end
