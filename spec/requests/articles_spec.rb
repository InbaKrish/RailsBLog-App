require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before{
    @test_user = Author.first_or_create!(email: 'rspectest@example.com', password: 'password', password_confirmation: 'password')
  }
  dummy_content ="Ruby on Rails, or Rails, is a server-side web application framework written in Ruby under the MIT License. Rails is a model–view–controller (MVC) framework, providing default structures for a database, a web service, and web pages. It encourages and facilitates the use of web standards such as JSON or XML for data transfer and HTML, CSS and JavaScript for user interfacing. In addition to MVC, Rails emphasizes the use of other well-known software engineering patterns and paradigms, including convention over configuration (CoC), don't repeat yourself (DRY), and the active record pattern.[4]Ruby on Rails' emergence in 2005 greatly influenced web app development, through innovative features such as seamless database table creations, migrations, and scaffolding of views to enable rapid application development. Ruby on Rails' influence on other web frameworks remains apparent today, with many frameworks in other languages borrowing its ideas, including Django in Python, Catalyst in Perl, Laravel, CakePHP and Yii in PHP, Grails in Groovy, Phoenix in Elixir, Play in Scala, and Sails.js in Node.js."

  let(:valid_attributes) do
    {
      id: '1',
      title: 'Test request',
      description: 'Test description ',
      content: dummy_content,
      author: @test_user
    }
  end

  let(:invalid_attributes) do
    {
      id: '1',
      title: 'Test request',
      description: 'Test description ',
      content: dummy_content
    }
  end

  describe "GET /index" do
    it "renders articles without auth" do
      get articles_path
      expect(response).to be_successful
    end
  end
  describe "GET /show" do
    it "renders article without auth" do
      article = Article.new(valid_attributes)
      article.author = @test_user
      article.save 
      get article_path(article)
      expect(response).to be_successful
    end
  end
  describe "GET /edit" do 
    it "renders edit path" do
      #sign_in @test_user
      article = Article.new(valid_attributes)
      article.author = @test_user
      article.save
      get edit_article_path(article)
      expect(response).to_not be_successful

      sign_in @test_user
      article = Article.new(valid_attributes)
      article.author = @test_user
      article.save
      get edit_article_path(article)
      expect(response).to be_successful
    end
  end
  describe "POST /create" do
    context "create with valid params" do
      it "creates new article" do
        expect {
          sign_in @test_user
          article = Article.new(valid_attributes)
          article.author = @test_user
          article.save
          post articles_path, params: { article: valid_attributes}
        }.to change(Article, :count).by(1)
      end
      it "redirects to articles path after destroy" do
        sign_in @test_user
        article = Article.new(valid_attributes)
        article.author = @test_user
        article.save
        delete articles_delete_path(article)
        expect(response).to redirect_to(articles_url)
      end
    end
    context "create with invalid params" do
      it "not creates new article" do
        expect {
          post articles_path, params: { article: invalid_attributes}
        }.to change(Article, :count).by(0)
      end
    end
  end
  describe "DELETE /destroy" do
    it "deletes the article" do
      sign_in @test_user
      article = Article.new(valid_attributes)
      article.author = @test_user
      article.save
      expect{
        delete articles_delete_path(article)
      }.to change(Article, :count).by(-1)
    end
    it "redirects to articles path after destroy" do
      sign_in @test_user
      article = Article.new(valid_attributes)
      article.author = @test_user
      article.save
      delete articles_delete_path(article)
      expect(response).to redirect_to(articles_url)
    end
  end
end
