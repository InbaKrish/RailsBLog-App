require 'rails_helper'

RSpec.describe Comment, type: :model do
  before {
    @test_user = Author.first_or_create!(email: 'rspectest@example.com', password: 'password', password_confirmation: 'password')
    dummy_content ="Ruby on Rails, or Rails, is a server-side web application framework written in Ruby under the MIT License. 
    Rails is a model–view–controller (MVC) framework, providing default structures for a database, a web service, and web pages. 
    It encourages and facilitates the use of web standards such as JSON or XML for data transfer and HTML, CSS and JavaScript for user interfacing. 
    In addition to MVC, Rails emphasizes the use of other well-known software engineering patterns and paradigms, 
    including convention over configuration (CoC), don't repeat yourself (DRY), and the active record pattern.[4]
    Ruby on Rails' emergence in 2005 greatly influenced web app development, through innovative features such as seamless database table creations, 
    migrations, and scaffolding of views to enable rapid application development. Ruby on Rails' influence on other web frameworks remains apparent today, 
    with many frameworks in other languages borrowing its ideas, including Django in Python, Catalyst in 
    Perl, Laravel, CakePHP and Yii in PHP, Grails in Groovy, Phoenix in Elixir, Play in Scala, and Sails.js in Node.js."
    article = Article.first_or_create!(
      title: "Comment test", description: "Test description ",
      content: dummy_content,
      author_id: @test_user.id
    ) 
    @test_cmt = article.comments.new()
  }

  context "Validations" do
    it "has user_id" do
      @test_cmt.content = "Testing comment model"
      expect(@test_cmt).to_not be_valid

      @test_cmt.user_id = @test_user.id
      expect(@test_cmt).to be_valid
    end
    it "has valid content" do
      @test_cmt.user_id = @test_user.id
      expect(@test_cmt).to_not be_valid

      @test_cmt.content = "Testing comment model"
      expect(@test_cmt).to be_valid
    end
    it "has content between 6 and 300" do
      @test_cmt.user_id = @test_user.id
      @test_cmt.content = "12345"
      expect(@test_cmt).to_not be_valid

      min = "123456"
      @test_cmt.content = min
      expect(@test_cmt).to be_valid

      max = "Wv}4kreEYQHP_F(]z*z!Pa3zC8fq;}PVX@HG9tyW!t!pt$6nN=_+S5ED:=LE:}ePY:p_rZndAWc]AWGnZhPYAaK,-,Md[]G?mGc9f8@$BE&Gf=N9-VK24n=-Ajb5Yx&r$8x{dqM2)i%#c2M3[q:uDp-/N)EhkAc[2/+,Kn4DCFU!/2[n$#Lpiq$g$!@[4JaF5qk*KPT-fAd6rmVJ=..c#]$qENJ4.+U9./]R6Cjg)S{x}MtenRJU_Uuq*r!8@[,(U;;/))R[V;c%-DC%]9zwf=A4Z}b}C(_uB.=/]BS4*)tJ"
      @test_cmt.content = max
      expect(@test_cmt).to be_valid

      @test_cmt.content = max + "1"
      expect(@test_cmt).to_not be_valid
    end
  end
end
