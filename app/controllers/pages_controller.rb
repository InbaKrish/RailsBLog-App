class PagesController < ApplicationController
    def home
        redirect_to articles_path if current_author
    end
    def about
    end
end
