require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "購物車基本功能" do

      it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
        cart = Cart.new                   # 新增一台購物車
        cart.add_item 1                   # 丟一個東西到購物車
        expect(cart.empty?).to be false   # 根據以上它不是空的
      end

      it "如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加" do
        cart = Cart.new                             # 新增一台購物車
        3.times { cart.add_item(1) }                # 加了 3 次的 1
        5.times { cart.add_item(2) }                # 加了 5 次的 2
        2.times { cart.add_item(3) }                # 加了 2 次的 3

        expect(cart.items.length).to be 3           # 總共應該會有 3 個 item
        expect(cart.items.first.quantity).to be 1   # 第 1 個 item 的數量會是 1
        expect(cart.items.second.quantity).to be 1  # 第 2 個 item 的數量會是 1

      end
      #it "商品可以放到購物車裡，也可以再拿出來"
    end

    describe "購物車進階功能" do
      it "可以將購物車內容轉換成 Hash，存到 Session 裡" do
        cart = Cart.new
        3.times { cart.add_item(2) }   # 新增商品 id 2
        4.times { cart.add_item(5) }   # 新增商品 id 5

        expect(cart.serialize).to eq session_hash
      end
      it "可以把 Session 的內容（Hash 格式），還原成購物車的內容" do
        cart = Cart.from_hash(session_hash)

        expect(cart.items.first.vendor_id).to be 2
        expect(cart.items.first.quantity).to be 1
        expect(cart.items.second.vendor_id).to be 5
        expect(cart.items.second.quantity).to be 1
      end
    end

    private
    def session_hash
      {
        "items" => [
          {"vendor_id" => 2, "quantity" => 1},
          {"vendor_id" => 5, "quantity" => 1}
        ]
      }
    end
end
