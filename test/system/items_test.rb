require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:one)
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
    
  end

  test "should create item" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    fill_in "Count", with: @item.count
    fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    fill_in "Price", with: @item.price
    fill_in "Sku", with: 'SKUNoDuplicate'
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "should fail to create item no count" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    # fill_in "Count", with: @item.count
    fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    fill_in "Price", with: @item.price
    fill_in "Sku", with: 'newsku'
    click_on "Create Item"

    assert_text "Count can't be blank"
    assert_text "Count is not a number"
    click_on "Back"
  end

  test "should fail to create item negative count" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    fill_in "Count", with: '-1'
    fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    fill_in "Price", with: @item.price
    fill_in "Sku", with: 'newsku'
    click_on "Create Item"

    assert_text "Count must be greater than or equal to 0"
    
    click_on "Back"
  end

  test "should fail to create item no price" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    fill_in "Count", with: @item.count
    fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    # fill_in "Price", with: @item.price
    fill_in "Sku", with: 'newsku'
    click_on "Create Item"

    assert_text "Price can't be blank"
    assert_text "Price is not a number"
    click_on "Back"
  end

  test "should fail to create item negative price" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    fill_in "Count", with: @item.count
    fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    fill_in "Price", with: "-1"
    fill_in "Sku", with: 'newsku'
    click_on "Create Item"

    assert_text "Price must be greater than or equal to 0"
    
    click_on "Back"
  end


  test "should fail to create item no name" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    fill_in "Count", with: @item.count
    fill_in "Description", with: @item.description
    #fill_in "Name", with: @item.name
    fill_in "Price", with: @item.price
    fill_in "Sku", with: 'newsku'
    click_on "Create Item"

    assert_text "Name can't be blank"
    click_on "Back"
  end

  test "should fail to create item no description" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    fill_in "Count", with: @item.count
    #fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    fill_in "Price", with: @item.price
    fill_in "Sku", with: 'newsku'
    click_on "Create Item"

    assert_text "Description can't be blank"
    click_on "Back"
  end

  test "should fail to create item no sku" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    fill_in "Count", with: @item.count
    fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    fill_in "Price", with: @item.price
    #fill_in "Sku", with: 'newsku'
    click_on "Create Item"

    assert_text "Sku can't be blank"
    click_on "Back"
  end

# Note that since we also destroy items, using second fixture SKU
  test "should fail to create item duplicate sku" do
    visit items_url
    click_on "New item"

    @newsku = @item.sku + ' etc'
    fill_in "Count", with: @item.count
    fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    fill_in "Price", with: @item.price
    fill_in "Sku", with: 'SKU456'
    click_on "Create Item"

    assert_text "Sku has already been taken"
    click_on "Back"
  end

  

  test "should update Item" do
    visit item_url(@item)
    click_on "Edit this item", match: :first

    fill_in "Count", with: @item.count
    fill_in "Description", with: @item.description
    fill_in "Name", with: @item.name
    fill_in "Price", with: @item.price
    fill_in "Sku", with: @item.sku
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "should destroy Item" do
    visit item_url(@item)
    click_on "Destroy this item", match: :first

    assert_text "Item was successfully destroyed"
  end
end
