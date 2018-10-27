class Api::FileController < ApplicationController
  protect_from_forgery except: :upload

  def upload
  end
end
