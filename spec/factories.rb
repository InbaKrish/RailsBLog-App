FactoryBot.define do 

    factory :author do
        email {'rspectest1@example.com'}
        password {'password'} 
        password_confirmation {'password'}
    end
    factory :article do
        association :author
        title { 'Test request'}
        description { 'Test description '}
        body { "Ruby on Rails, or Rails, is a server-side web application framework written in Ruby under the MIT License. Rails is a model–view–controller (MVC) framework, providing default structures for a database, a web service, and web pages. It encourages and facilitates the use of web standards such as JSON or XML for data transfer and HTML, CSS and JavaScript for user interfacing. In addition to MVC, Rails emphasizes the use of other well-known software engineering patterns and paradigms, including convention over configuration (CoC), don't repeat yourself (DRY), and the active record pattern.[4]Ruby on Rails' emergence in 2005 greatly influenced web app development, through innovative features such as seamless database table creations, migrations, and scaffolding of views to enable rapid application development. Ruby on Rails' influence on other web frameworks remains apparent today, with many frameworks in other languages borrowing its ideas, including Django in Python, Catalyst in Perl, Laravel, CakePHP and Yii in PHP, Grails in Groovy, Phoenix in Elixir, Play in Scala, and Sails.js in Node.js."}
    end
    factory :category do
        association :article
        name {""}
    end
end