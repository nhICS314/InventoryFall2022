require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get items_url
    assert_response :success
  end

  test "should get new" do
    get new_item_url
    assert_response :success
  end

  test "should create item" do
    assert_difference("Item.count") do
      post items_url, params: { item: { count: @item.count, description: @item.description, name: @item.name, price: @item.price, sku: @item.sku + "random text" } }
    end

    assert_redirected_to item_url(Item.last)
  end

  test "should fail to create item no sku" do
    assert_no_difference("Item.count") do
      post items_url, params: { item: { count: @item.count, description: @item.description, name: @item.name, price: @item.price} }
    end

    assert_response :unprocessable_entity
  end

  test "should fail to create item duplicate sku" do
    assert_no_difference("Item.count") do
      post items_url, params: { item: { count: @item.count, description: @item.description, name: @item.name, price: @item.price, sku: @item.sku } }
    end

    assert_response :unprocessable_entity
  end

  test "should fail to create item no name" do
    assert_no_difference("Item.count") do
      post items_url, params: { item: { count: @item.count, description: @item.description, price: @item.price,  sku: @item.sku + "random text"} }
    end

    assert_response :unprocessable_entity
  end

  test "should fail to create item no description" do
    assert_no_difference("Item.count") do
      post items_url, params: { item: { count: @item.count, name: @item.name, price: @item.price,  sku: @item.sku + "random text"} }
    end

    assert_response :unprocessable_entity
  end

  test "should fail to create item no price" do
    assert_no_difference("Item.count") do
      post items_url, params: { item: { count: @item.count, name: @item.name, description: @item.description,  sku: @item.sku + "random text"} }
    end

    assert_response :unprocessable_entity
  end

  test "should fail to create item negative price" do
    assert_no_difference("Item.count") do
      post items_url, params: { item: { count: @item.count, name: @item.name, description: @item.description, price: -1,  sku: @item.sku + "random text"} }
    end

    assert_response :unprocessable_entity
  end

  test "should fail to create item no count" do
    assert_no_difference("Item.count") do
      post items_url, params: { item: { name: @item.name, description: @item.description, price: @item.price,  sku: @item.sku + "random text"} }
    end

    assert_response :unprocessable_entity
  end

  test "should fail to create item negative count" do
    assert_no_difference("Item.count") do
      post items_url, params: { item: { count: -1, name: @item.name, description: @item.description, price: @item.price,  sku: @item.sku + "random text"} }
    end

    assert_response :unprocessable_entity
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: { item: { count: @item.count, description: @item.description, name: @item.name, price: @item.price, sku: @item.sku } }
    assert_redirected_to item_url(@item)
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do 
      delete item_url(@item), params: { item: { count: @item.count, description: @item.description, name: @item.name, price: @item.price, sku: @item.sku } }
    end
    assert_redirected_to items_url
  end



end
