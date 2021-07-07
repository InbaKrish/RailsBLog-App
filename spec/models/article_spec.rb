require "rails_helper"

RSpec.describe Article, type: :model do
    #dummy data for testing
    before{
        @test_user = create(:author)
    }
    dummy_body ="Ruby on Rails, or Rails, is a server-side web application framework written in Ruby under the MIT License. 
    Rails is a model–view–controller (MVC) framework, providing default structures for a database, a web service, and web pages. 
    It encourages and facilitates the use of web standards such as JSON or XML for data transfer and HTML, CSS and JavaScript for user interfacing. 
    In addition to MVC, Rails emphasizes the use of other well-known software engineering patterns and paradigms, 
    including convention over configuration (CoC), don't repeat yourself (DRY), and the active record pattern.[4]
    Ruby on Rails' emergence in 2005 greatly influenced web app development, through innovative features such as seamless database table creations, 
    migrations, and scaffolding of views to enable rapid application development. Ruby on Rails' influence on other web frameworks remains apparent today, 
    with many frameworks in other languages borrowing its ideas, including Django in Python, Catalyst in 
    Perl, Laravel, CakePHP and Yii in PHP, Grails in Groovy, Phoenix in Elixir, Play in Scala, and Sails.js in Node.js."

    it "has a title" do
        article = Article.new(
            title: "", description: "Test description ",
            body: dummy_body,
            author_id: @test_user.id
        )
        expect(article).to_not be_valid
        article.title = "Rails wiki"
        expect(article).to be_valid
    end
    it "has a description" do
        article = Article.new(
            title: "Rails wiki", description: "",
            body: dummy_body,
            author_id: @test_user.id
        )
        expect(article).to_not be_valid
        article.description = "Test description rr"
        expect(article).to be_valid
    end
    it "has a body" do
        article = Article.new(
            title: "Rails wiki", description: "Test description rr",
            body: "",
            author_id: @test_user.id
        )
        expect(article).to_not be_valid
        article.body = dummy_body
        expect(article).to be_valid
    end
    it 'has a title between 6 and 80 characters' do
        article = Article.new(
            title: "Ra", description: "Test description rr",
            body: dummy_body,
            author_id: @test_user.id
        )
        expect(article).to_not be_valid
    
        article.title = '123456'
        expect(article).to be_valid
    
        max_char = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula '
        article.title = max_char
        expect(article).to be_valid
    
        article.title = max_char + '1'
        expect(article).to_not be_valid
    end
    it 'has a description between 15 and 600 characters' do
        article = Article.new(
            title: "123456", description: "",
            body: dummy_body,
            author_id: @test_user.id
        )
        expect(article).to_not be_valid
    
        article.description = 'dMaELBzbEZQvOVV'
        expect(article).to be_valid
    
        max_char = 'T#yUf]cW6N=V4_3G9L25,+%vt{Ca_.NSvT)JM5-]vB57g877TD:#y#yX{p]hn[U8G+VmF]2SYwdX#,-k2f[wEM=dL_Un{!+wD&Q#XY@Ypq3FPC-(F4G7Td582%7PU@j/=erRFimpj?t4!!]Bki_y.ZC9[#QDkpLCBNyDzB_nDXj[P}r5T]7@az#]=+7S]!6vFbru&vT[Y]%gZKM_]Q.hjU5F2$*[/8$t}CDrR,zD5}U8?g7kq3qcAY-mG;a!aim&7=q3d=[)T8/wgUKCTFFw]xVArCvB=;GN_:xJ4R:2m*pjt{.U#(N:eL%g}JrPt5-SwH.t%{YLEz.,4fj.eee)djJ$D=uim&m;X2pcapwT5]JT6Kc8SgR7RHw,UJP(c}&nNJv*dd6u$FYASTpqMh.PM2quD6$f@!:+#;63M2$5(7c2LJVfdmx;M}fGEZaD:LvQ.BRX},%GbzSnb%PNP?k]MU@Pp+k(,kd$$2d=AQ]E4ctg-V/ud?HD)f:Xt?-:V]i%=4X#]ezf2ahY=Ua=-d&azK/8F=nH&QBx=fn_dXvc{Y,)TmCVyH#cv?6e+}*fuDH9zD334=*x&{$:SRcSt?6Z/Cv6'
        article.description = max_char
        expect(article).to be_valid
    
        article.description = max_char + '1'
        expect(article).to_not be_valid
    end
end