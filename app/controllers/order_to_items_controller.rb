class OrderToItemsController < ApplicationController
  before_action :set_order_to_item, only: [:show, :edit, :update, :destroy]

  # GET /order_to_items
  # GET /order_to_items.json
  def index
    @order_to_items = OrderToItem.all
  end

  # GET /order_to_items/1
  # GET /order_to_items/1.json
  def show
  end

  # GET /order_to_items/new
  def new
    @order_to_item = OrderToItem.new
  end

  # GET /order_to_items/1/edit
  def edit
  end

  # POST /order_to_items
  # POST /order_to_items.json
  def create
    @order_to_item = OrderToItem.new(order_to_item_params)

    respond_to do |format|
      if @order_to_item.save
        format.html { redirect_to @order_to_item, notice: 'Order to item was successfully created.' }
        format.json { render :show, status: :created, location: @order_to_item }
      else
        format.html { render :new }
        format.json { render json: @order_to_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_to_items/1
  # PATCH/PUT /order_to_items/1.json
  def update
    respond_to do |format|
      if @order_to_item.update(order_to_item_params)
        format.html { redirect_to @order_to_item, notice: 'Order to item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_to_item }
      else
        format.html { render :edit }
        format.json { render json: @order_to_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_to_items/1
  # DELETE /order_to_items/1.json
  def destroy
    @order_to_item.destroy
    respond_to do |format|
      format.html { redirect_to order_to_items_url, notice: 'Order to item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_to_item
      @order_to_item = OrderToItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_to_item_params
      params.require(:order_to_item).permit(:order_id, :item_id)
    end
end
