require 'rails_helper'

RSpec.describe Comment, type: :model do
  before {
    @test_user = create(:author)
    article = create(:article ,author_id: @test_user.id)
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
