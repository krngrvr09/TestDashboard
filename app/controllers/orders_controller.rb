class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    final_result=[]
    @orders.each do |order|
      items = order.items.split(",")
      item_list=[]
      items.each do |i|
        tmp = Item.find(i)
        if tmp
          item_list<<tmp
        end
      end
      order_result = order.as_json
      order_result["items"] = item_list
      final_result<<order_result
    end

    respond_to do |format|

	   format.json  { render :json => { :orders => final_result } } # don't do msg
    end
    
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
	 @order = Order.find(params[:id])
    respond_to do |format|

      format.json  { render :json => { :orders => @order.as_json(:include => :items) } } # don't do msg.to_json
    end

  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    a = order_params
    puts "a"
    puts a
    @order = Order.new(a)
    puts "@order"
    puts @order
    b =a[:items].split(",")
    puts "b"
    puts b
    respond_to do |format|
      if @order.save
        puts "@order"
        puts @order
        b.each do |i|
          order_to_item = OrderToItem.new({order_id:@order.id, item_id: i})
          puts order_to_item.save
        end
        reg_id = User.find(1).reg_id#user.reg_id
        gcm = GCM.new("AIzaSyD-nMzxBqyTL8vTyV4bEq0_hBm5Y49eJ4Q")
        registration_ids= [reg_id] # an array of one or more client registration IDs
        # registration_ids= registration_ids#[reg_id] # an array of one or more client registration IDs
        options = {data: {order_id: @order.id}, collapse_key: "Order"}
        response = gcm.send(registration_ids, options)
        puts response
        
    
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json  { render :json => { :orders => @order.as_json } } # don't do msg.to_json
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def order_complete
    require 'gcm'
    order_id = params[:order_id]
    # reg_id = params[:reg_id]
    order = Order.find(order_id)
    response = "order not found"
    if order
      user_id = order.user_id
      user = User.find(user_id)
      response = "user not found"
      if user
        reg_id = "e8qP5arN9uM:APA91bHt-LIGSNEY0iZdN8-uef0fI0mbBTk_Rrq7LwPfkkuLPSX-SUOH5iscY4jJ7jzFB-he0xTLDH4u8GOAvVCJOllei2ZlVOH8BL6nTyJ_hj674EaOP8ckOwMjhLOJBXOedQO_rHfH"#user.reg_id
        # reg_id="cjRSI3BvQEo:APA91bHwoWqP0oFLcKII2roSY92qiAK1QLHnd4ZSsJBu-F-wNM9pU58l1YeIoEh5JS3BeZ-fnfzAQptkzScpeGZYp0Nvte8LiKlDE0HUsrOPICCZhMQKKPQfmhlo2zT6E50Au6fDfm0L"
        gcm = GCM.new("AIzaSyD-nMzxBqyTL8vTyV4bEq0_hBm5Y49eJ4Q")
        # registration_ids= ["dfqivEnV2bY:APA91bHZOm7uCgGns-FvLURMImMR2Wx2X3aErkui8fdRIJHkKUBIiRoTamFJeWwHVMXt2uEjEW3WkfTa5rUrWIT_hxW_VnolvLcVZaTwC_YfE3HXM6mSSj1vzRHGa4yyiD0_PkIyCacL"] # an array of one or more client registration IDs
        registration_ids= [reg_id] # an array of one or more client registration IDs
        options = {data: {order_id: order_id}, collapse_key: "Order"}
        response = gcm.send(registration_ids, options)
        puts response  
      end
    end
    respond_to do |format|
      msg = { :response => response }
      format.json  { render :json => msg } # don't do msg.to_json
    end  
  end


  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.permit(:status,:paid,:payment_status,:user_id,:cost,:items)
    end
end
