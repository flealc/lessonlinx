class UsersController < ApplicationController
  before_action :set_user


def dashboard
  authorize @user
end

private

def set_user
  @user = current_user
end

end
