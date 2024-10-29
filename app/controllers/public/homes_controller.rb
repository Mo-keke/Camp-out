class Public::HomesController < ApplicationController
  def top
    @public_homes = true
  end

  def about
    @public_homes = true
  end
end
