class UserToItemsController < ApplicationController
  before_action :set_user_to_item, only: [:show, :edit, :update, :destroy]

  # GET /user_to_items
  # GET /user_to_items.json
  def index
    @user_to_items = UserToItem.all
  end

  # GET /user_to_items/1
  # GET /user_to_items/1.json
  def show
  end

  # GET /user_to_items/new
  def new
    @user_to_item = UserToItem.new
  end

  # GET /user_to_items/1/edit
  def edit
  end

  # POST /user_to_items
  # POST /user_to_items.json
  def create
    @user_to_item = UserToItem.new(user_to_item_params)

    respond_to do |format|
      if @user_to_item.save
        format.html { redirect_to @user_to_item, notice: 'User to item was successfully created.' }
        format.json { render :show, status: :created, location: @user_to_item }
      else
        format.html { render :new }
        format.json { render json: @user_to_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_to_items/1
  # PATCH/PUT /user_to_items/1.json
  def update
    respond_to do |format|
      if @user_to_item.update(user_to_item_params)
        format.html { redirect_to @user_to_item, notice: 'User to item was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_to_item }
      else
        format.html { render :edit }
        format.json { render json: @user_to_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_to_items/1
  # DELETE /user_to_items/1.json
  def destroy
    @user_to_item.destroy
    respond_to do |format|
      format.html { redirect_to user_to_items_url, notice: 'User to item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_to_item
      @user_to_item = UserToItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_to_item_params
      params.require(:user_to_item).permit(:user_id, :item_id)
    end
end
