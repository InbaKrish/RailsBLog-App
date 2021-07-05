class Api::V1::AuthorsController < ApplicationController
    before_action :doorkeeper_authorize!
    #all users json
    def index
        @authors = Author.all
        render json: @authors
    end
    #user json
    def show
        @author = Author.find(params[:id])
        render json: @author
    end
end
