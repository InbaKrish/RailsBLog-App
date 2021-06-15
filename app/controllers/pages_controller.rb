class PagesController < ApplicationController
    def home
        redirect_to articles_path if cur_user
    end
    def about
    end
end
