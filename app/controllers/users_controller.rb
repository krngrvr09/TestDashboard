class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      msg = { :users => @users }
      format.json  { render :json => msg } # don't do msg.to_json
    end
    
  end

  def get_orders
    user_id = params[:user_id]
    user = User.find(user_id)
    if user
      respond_to do |format|
      msg = { :orders => user.orders }
      format.json  { render :json => msg } # don't do msg.to_json
    end
    end

  end

  def set_gcm
    require 'gcm'
    user_id = params[:user_id]
    reg_id = params[:reg_id]
    user = User.find(user_id)
    if user
      # gcm = GCM.new("AIzaSyD-nMzxBqyTL8vTyV4bEq0_hBm5Y49eJ4Q")
      # registration_ids= ["dfqivEnV2bY:APA91bHZOm7uCgGns-FvLURMImMR2Wx2X3aErkui8fdRIJHkKUBIiRoTamFJeWwHVMXt2uEjEW3WkfTa5rUrWIT_hxW_VnolvLcVZaTwC_YfE3HXM6mSSj1vzRHGa4yyiD0_PkIyCacL"] # an array of one or more client registration IDs
      user.reg_id = reg_id
      user.save
      # registration_ids= [reg_id] # an array of one or more client registration IDs
      # options = {data: {score: "123"}, collapse_key: "updated_score"}
      # response = gcm.send(registration_ids, options)
      # puts response
      respond_to do |format|
        msg = { :response => "ok" }
      format.json  { render :json => msg } # don't do msg.to_json
    end

    end      
  end

  def get_id
    puts "1"
    email = params[:email]
    puts "2"
    name = params[:name]
    puts "3"
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    puts "4"
    puts name
    puts "5"
    puts email
    puts "6"
    user = User.where(:email=>email).first
    result = {}
    final = []
    if user
      result["id"] = user.id
      final.push result
      puts "user present"
      puts result
      puts "11"
    else
      puts "user not presen"
      user_params={}
      puts "13"
      user_params['name'] = name
      puts "14"
      user_params['email'] = email      
      puts "15"
      new_user = User.new(user_params)
      puts "16"
      if new_user.save
        result = new_user.id
        puts "18"
      end
      puts "19"
    end
    puts "20"
    respond_to do |format|
      msg = { :user_id => final }
      format.json  { render :json => msg } # don't do msg.to_json
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
