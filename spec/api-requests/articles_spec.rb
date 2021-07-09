require 'rails_helper'

RSpec.describe "Api::V1::ArticlesController" , type: :request do
    let(:oauth_app) { 
        Doorkeeper::Application.create!(
          name: "RSpec-client", 
          redirect_uri: "" 
        ) 
      }
    let(:access_token)  { Doorkeeper::AccessToken.create!(application: oauth_app) }
    let(:authorization) { "Bearer #{access_token.token}" }
    before{
        @test_user = create(:author)
        @test_article = create(:article, author_id: @test_user.id)
    }
    describe "GET /all_articles" do
        it "renders all articles" do
            get '/api/v1/articles',headers: {:Authorization => authorization}
            expect(response).to be_successful
        end
        it "without token" do
            get '/api/v1/articles'
            expect(response).to_not be_successful
        end
    end
    describe "GET /index" do
        it "renders user's articles" do
            get user_articles_path(id: @test_user.id),headers: {:Authorization => authorization}
            expect(response).to be_successful
        end
    end
    describe "GET /show" do
        it "renders article" do
            get api_v1_article_path(id: @test_article.id),headers: {:Authorization => authorization}
            expect(response).to be_successful
        end
    end
end