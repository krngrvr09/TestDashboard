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

  def get_id
    email = params[:email]
    name = params[:name]
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    puts name
    puts email
    user = User.where(:email=>email).first
    result = {}
    final = []
    if user
      result["id"] = user.id
      final.push result
      puts "user present"
      puts result
    else
      puts "user not present"
      user_params={}
      user_params['name'] = name
      user_params['email'] = email      
      new_user = User.new(user_params)
      if new_user.save
        puts "user saved successfully"
        result = new_user.id
      end
    end
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
