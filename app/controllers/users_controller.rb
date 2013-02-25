class UsersController < ApplicationController
  # authorize_actions_for UsersAuthorizer, actions: { index: 'read' }
  before_filter :authenticate_user!

  def index
    @users = User.all
    authorize_action_for(current_user)
  end
end
