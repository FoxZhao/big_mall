require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username: "username",
                     mobile: "13651029440",
                     email: "username@example.com",
                     password: "12345678")
  end

  test 'role should be user' do
    assert @user.save
    assert_equal @user.role, 'user'
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username can be blank" do
    @user.username = "  "
    assert @user.valid?
  end

  # test "username should be longer than 6" do
  #   @user.username = "12345"
  #   assert_not @user.valid?
  # end

  test "username should be shorter than 16" do
    @user.username = "12345678901234567"
    assert_not @user.valid?
  end

  test "mobile should be present" do
    @user.mobile = "  "
    assert_not @user.valid?
  end

  test "mobile invalid test" do
    invalid_mobiles = %w[1 1234567890 12345678901
                         123456789012 19912345678]
    invalid_mobiles.each do |invalid_mobile|
      @user.mobile = invalid_mobile
      assert_not @user.valid?, "#{invalid_mobile} should be invalid"
    end
    
  end

  test "mobile valid test" do
    valid_mobiles = %w[13510116000 13602632481 15989426000
                       18820965455 18665567887 13112344321]
    valid_mobiles.each do |valid_mobile|
      @user.mobile = valid_mobile
      assert @user.valid?, "#{valid_mobile} should be valid"
    end
    
  end

  test "mobile should be unique" do
    same_mobile_user = User.new(username: "user001",
                                mobile: @user.mobile,
                                email: "q124@126.com",
                                password: "87654321")
    @user.save
    assert_not same_mobile_user.valid?
  end  

  test "email can be blank" do
    @user.email = "  "
    assert @user.valid?
  end

  test "email valid test" do
    valid_addresses = %w[a123@example.com zhaozihaozz@126.com 
                         395381480@qq.com hartl@tutorial.org]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} should be valid"
    end
  end

  test "email invalid test" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com invalid@qq..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} should be invalid"
    end
  end

  test "email should be unique" do
    same_email_user = User.new(username: "user001",
                                mobile: "13510116000",
                                email: @user.email,
                                password: "87654321")
    @user.save
    assert_not same_email_user.valid?
  end


  test "password should be present" do
    @user.password = "  "
    assert_not @user.valid?
  end
end
