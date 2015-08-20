require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = Merchant.new(username: 'merchant001',
                mobile: '13251029440',
                email: 'merchant001@example.com',
                password: '12345678',
                password_confirmation: '12345678')
  end

  test 'table name should be the same as User' do
    assert_equal User.table_name, Merchant.table_name
  end

  test 'role should be merchant' do
    assert @user.save
    assert_equal @user.role, 'merchant'
  end

  test "password_confirmation should be as same as password" do
    @user.password_confirmation = "87654321"
    assert_not @user.valid?
    assert_not @user.save
  end
end
