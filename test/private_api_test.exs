defmodule CheckonomyTest.PrivateApi do
  use ExUnit.Case
  doctest Checkonomy

  test "test get_info endpoint. will return personal information regarding balance." do
    assert {:ok, %{"return" => _return, "success" => 1}} = Tokex.get_info()
  end   

  test "test open_orders endpoint" do
    assert {:ok, %{"return" => _return, "success" => 1}} = Tokex.open_orders()
  end 

  test "test order_history endpoint" do
    assert {:ok, %{"return" => _return, "success" => 1}} = Tokex.order_history("ten_btc")
  end

  test "test trans_history endpoint" do
    assert {:ok, %{"return" => _return, "success" => 1}} = Tokex.trans_history()
  end

  test "test trade endpoint with insufficient balance" do
    assert {:ok,
             %{
               "error" => "You have insufficient balance!",
               "is_error" => true,
               "success" => 0
             }} = Tokex.trade("zec_btc", "buy", 0.000200, [zec: 1000])
  end

  test "test trade endpoint with Invalid pair" do
    assert {:ok, %{"error" => "Invalid pair.", "success" => 0}} = Tokex.trade("xxx_xxx", "buy", 0.000200, [xxx: 1000])
  end    

  test "test trade endpoint with valid params and then cancel it" do
    assert {:ok, %{"order_id" => order_id, "success" => 1}} = Tokex.trade("zec_btc", "buy", 0.000200, [zec: 1])
    assert {:ok, %{"return" => %{"order_id" => order_id}, "success" => 1}} = Tokex.cancel_order("zec_btc", order_id ,"buy")    
  end     

end
