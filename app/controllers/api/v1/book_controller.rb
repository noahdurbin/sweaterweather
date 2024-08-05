class Api::V1::BookController < ApplicationController
  def search
    render json: BookFacade.new.search_books(params[:location], params[:quantity])
  end
end
