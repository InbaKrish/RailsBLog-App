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
        @test_user = Author.first_or_create!(email: 'rspectest@example.com', password: 'password', password_confirmation: 'password')
        @test_article = Article.first_or_create!(
            id: '1',
            title: 'Test request',
            description: 'Test description ',
            content: "Ruby on Rails, or Rails, is a server-side web application framework written in Ruby under the MIT License. Rails is a model–view–controller (MVC) framework, providing default structures for a database, a web service, and web pages. It encourages and facilitates the use of web standards such as JSON or XML for data transfer and HTML, CSS and JavaScript for user interfacing. In addition to MVC, Rails emphasizes the use of other well-known software engineering patterns and paradigms, including convention over configuration (CoC), don't repeat yourself (DRY), and the active record pattern.[4]Ruby on Rails' emergence in 2005 greatly influenced web app development, through innovative features such as seamless database table creations, migrations, and scaffolding of views to enable rapid application development. Ruby on Rails' influence on other web frameworks remains apparent today, with many frameworks in other languages borrowing its ideas, including Django in Python, Catalyst in Perl, Laravel, CakePHP and Yii in PHP, Grails in Groovy, Phoenix in Elixir, Play in Scala, and Sails.js in Node.js.",
            author: @test_user
        )}

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