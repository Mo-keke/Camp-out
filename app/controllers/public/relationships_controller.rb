class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def followings
  end

  def followers
  end
end
