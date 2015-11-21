class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    respond_to do |format|

      
      format.json  { render :json => { :orders => @orders.to_json(:include => :items) } } # don't do msg.to_json
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
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    a = order_params
    
    puts "lolol"+a.to_s
    # order_params[:items] = order_params[:items].split(",")
    @order = Order.new(a.except(:items))
    puts"array"
    b =a[:items].split(",")
    # puts b
    b.each do |i|
      @order.items << Item.find(i)
    end
    # @order.user = User.find(1)
    # @order.items << Item.find(1)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json  { render :json => { :orders => @order.as_json(:include => :items) } } # don't do msg.to_json
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
        reg_id = user.reg_id
        gcm = GCM.new("AIzaSyD-nMzxBqyTL8vTyV4bEq0_hBm5Y49eJ4Q")
        # registration_ids= ["dfqivEnV2bY:APA91bHZOm7uCgGns-FvLURMImMR2Wx2X3aErkui8fdRIJHkKUBIiRoTamFJeWwHVMXt2uEjEW3WkfTa5rUrWIT_hxW_VnolvLcVZaTwC_YfE3HXM6mSSj1vzRHGa4yyiD0_PkIyCacL"] # an array of one or more client registration IDs
        registration_ids= [reg_id] # an array of one or more client registration IDs
        options = {data: {score: "123"}, collapse_key: "updated_score"}
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
