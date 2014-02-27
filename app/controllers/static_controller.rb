class StaticController < ApplicationController
  def index
  end

  def ping
    head :ok
  end
end
