require 'rails_helper'

RSpec.describe Author, type: :model do
  dummy_pwd = 'password'
  dummy_email = 'tester@example.com'

  context "validations" do
    author = Author.new(
      email: dummy_email,password: dummy_pwd,password_confirmation: dummy_pwd
    )
    it "has a email" do
      author.email = ""
      expect(author).to_not be_valid
      author.email = dummy_email
      expect(author).to be_valid
    end
    it "has a password confirmation" do
      author.password_confirmation = "password1"
      expect(author).to_not be_valid
      author.password_confirmation = dummy_pwd
      expect(author).to be_valid
    end
  end
end
