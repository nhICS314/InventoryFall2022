class ItemsController < ApplicationController
  handle_api_errors()
  before_action :set_item, only: %i[ show edit update destroy ]

  skip_before_action :verify_authenticity_token

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  

  # GET /items/1 or /items/1.json
  def show
  end

  def restore
    @item = Item.with_deleted.find(params[:id])
    @item.restore
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully restored." }
      format.json { render :show, status: :created, location: @item }
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    puts params
    puts 'beginning'
    if(params.has_key?(:item))
      puts 'before update'
      @item.update(item_params)
      puts 'after update'
    end
    puts 'before destroy'
    @item.destroy!
    puts 'after destroy'

    puts 'before respond'
    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { render json: '{ "message" : "Item was successfully destroyed." }', status: :ok  }
    end
    puts 'after respond'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
      if @item.nil?
        respond_to do |format|
          format.html { redirect_to items_url, notice: "Item was not found." }
          format.json { render json: '{ "message" : "Item was not found" }', status: :not_found }
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :price, :description, :sku, :count, :deletedComment)
    end
end
