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
        #reg_id = "fHHk-8AhHJs:APA91bGUtD9I1SQMlfLu0_z89Lga6r7mc5UsiQCE6j9ZhPE2LCsBIs8z8hJb6cKshufjsu047rgMHQFpJfsH8QQR789N4ycGd6S1NJdcr7sBpixNBWttinavxMaCfgnVj2NBMk4V26Zm"#user.reg_id
        reg_id=" elA5YVlT6s8:APA91bFH52_JycndajW2JrFNMTtx_zlAOBkNumuAC2_4Y6sygyJbP5MK5TlUaNmVfhJIbec0fKaZC0KNBtW72Y0vSkekFzSN_j9Szno2qYYmSsYdFNA4801hJwAMPvhxCjInqOO2niRr"
          gcm = GCM.new("AIzaSyD-nMzxBqyTL8vTyV4bEq0_hBm5Y49eJ4Q")
          # registration_ids= ["dfqivEnV2bY:APA91bHZOm7uCgGns-FvLURMImMR2Wx2X3aErkui8fdRIJHkKUBIiRoTamFJeWwHVMXt2uEjEW3WkfTa5rUrWIT_hxW_VnolvLcVZaTwC_YfE3HXM6mSSj1vzRHGa4yyiD0_PkIyCacL"] # an array of one or more client registration IDs
          registration_ids= [reg_id] # an array of one or more client registration IDs
          options = {data: {item: item.as_json}, collapse_key: "New_Item_Created"}
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
    respond_to do |format|
      if @item.save
        reg_id = "fHHk-8AhHJs:APA91bGUtD9I1SQMlfLu0_z89Lga6r7mc5UsiQCE6j9ZhPE2LCsBIs8z8hJb6cKshufjsu047rgMHQFpJfsH8QQR789N4ycGd6S1NJdcr7sBpixNBWttinavxMaCfgnVj2NBMk4V26Zm"#user.reg_id
        gcm = GCM.new("AIzaSyD-nMzxBqyTL8vTyV4bEq0_hBm5Y49eJ4Q")
        # registration_ids= ["dfqivEnV2bY:APA91bHZOm7uCgGns-FvLURMImMR2Wx2X3aErkui8fdRIJHkKUBIiRoTamFJeWwHVMXt2uEjEW3WkfTa5rUrWIT_hxW_VnolvLcVZaTwC_YfE3HXM6mSSj1vzRHGa4yyiD0_PkIyCacL"] # an array of one or more client registration IDs
        registration_ids= [reg_id] # an array of one or more client registration IDs
        options = {data: {item: @item.as_json}, collapse_key: "New_Item_Created"}
        response = gcm.send(registration_ids, options)
        puts response
    
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
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
