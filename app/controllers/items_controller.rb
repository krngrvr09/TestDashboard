class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    respond_to do |format|
      msg = { :items => @items }
      format.json  { render :json => msg } # don't do msg.to_json
    end
    
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end
  def new_item_notif
      item_id = params[:item_id]
      item = Item.find(item_id)
      if item
        reg_id = "e8qP5arN9uM:APA91bHt-LIGSNEY0iZdN8-uef0fI0mbBTk_Rrq7LwPfkkuLPSX-SUOH5iscY4jJ7jzFB-he0xTLDH4u8GOAvVCJOllei2ZlVOH8BL6nTyJ_hj674EaOP8ckOwMjhLOJBXOedQO_rHfH"#user.reg_id
        # reg_id="d3wjxDw2D2I:APA91bHch4up89ZVYtNtw6eM3eXMAjKbVXjsSS1Q1FvVx9jbsyBfXq252cEQMwFweedsGJKswGS-exzxQu4fVclcSm1UcwApW8bUCrn_p15fVuofj21PKzU_p8lQPAXo73umrbGdukjO"
          gcm = GCM.new("AIzaSyD-nMzxBqyTL8vTyV4bEq0_hBm5Y49eJ4Q")
          # registration_ids= ["dfqivEnV2bY:APA91bHZOm7uCgGns-FvLURMImMR2Wx2X3aErkui8fdRIJHkKUBIiRoTamFJeWwHVMXt2uEjEW3WkfTa5rUrWIT_hxW_VnolvLcVZaTwC_YfE3HXM6mSSj1vzRHGa4yyiD0_PkIyCacL"] # an array of one or more client registration IDs
          registration_ids= [reg_id] # an array of one or more client registration IDs
          options = {data: {item: item.as_json}, collapse_key: "Item"}
          response = gcm.send(registration_ids, options)
          puts response
        else
          response = "item not found"
        end
        respond_to do |format|
      msg = { :response => response }
      format.json  { render :json => msg } # don't do msg.to_json
    end  
    
  end

  # POST /items
  # POST /items.json
  def create
    puts item_params
    @item = Item.new(item_params)
    puts "!!!!!!!!!!!!!!!!!!!!"
    puts item_params
    respond_to do |format|
      if @item.save

        reg_id = "d8MFDvTOJU4:APA91bErYqWUBs7xpu4cHvFNtH73Rup84rHdOzmMVCyRHeBFUgx96WFWE4q5Jhb-FvZRzMVJP6cDNufGjeafW9fBYIHeuGC-wWuiaHLY0JTrwVcFR_MW67L_Gv2gOzZBgRgMRhAwwJHt"#user.reg_id
        gcm = GCM.new("AIzaSyD-nMzxBqyTL8vTyV4bEq0_hBm5Y49eJ4Q")
        registration_ids= [] # an array of one or more client registration IDs
        User.all.each do |u|
          registration_ids<<u.reg_id
        end
        # registration_ids= registration_ids#[reg_id] # an array of one or more client registration IDs
        options = {data: {item: @item.as_json(:except=>:image)}, collapse_key: "Item"}
        response = gcm.send(registration_ids, options)
        puts response
        # respond_to do |format|
        #   format.json  { render :json => @item.as_json } # don't do msg.to_json
        # end
    
        # format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :json => @item.as_json }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.permit(:name, :price, :quantity, :image, :rating, :contents)
    end
end
