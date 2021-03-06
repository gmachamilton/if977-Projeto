class GymsController < ApplicationController
  before_action :set_gym, only: [:show, :edit, :update, :destroy]
  
  def add_favorite
    begin
      @gym = Gym.find(params[:id])
      current_user.follow(@gym)
      render :show
    end
  end
  
  def remove_favorite
    begin
      @gym = Gym.find(params[:id])
      current_user.stop_following(@gym)
      render :show
    end
  end
     
  def vote_up
    begin
      @gym = Gym.find(params[:id])
      if current_user.voted_for?(@gym)
        current_user.unvote_for(@gym)
        render :show
      else
        current_user.vote_exclusively_for(@gym)   
        render :show
      end
    end
  end

  def vote_down
    begin
      @gym = Gym.find(params[:id])
      if current_user.voted_against?(@gym)
        current_user.unvote_for(@gym)
        render :show
      else
        current_user.vote_exclusively_against(@gym)   
        render :show
      end
    end
  end
  # GET /gyms
  # GET /gyms.json
  def index
    @gyms = Gym.all
  end

  # GET /gyms/1
  # GET /gyms/1.json
  def show
    @gym = Gym.find(params[:id])
  end

  # GET /gyms/new
  def new
    @gym = Gym.new
  end

  # GET /gyms/1/edit
  def edit
  end

  # POST /gyms
  # POST /gyms.json
  def create
    @gym = Gym.new(gym_params)

    respond_to do |format|
      if @gym.save
        format.html { redirect_to @gym, notice: 'Gym was successfully created.' }
        format.json { render :show, status: :created, location: @gym }
      else
        format.html { render :new }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gyms/1
  # PATCH/PUT /gyms/1.json
  def update
    respond_to do |format|
      if @gym.update(gym_params)
        format.html { redirect_to @gym, notice: 'Gym was successfully updated.' }
        format.json { render :show, status: :ok, location: @gym }
      else
        format.html { render :edit }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gyms/1
  # DELETE /gyms/1.json
  def destroy
    @gym.destroy
    respond_to do |format|
      format.html { redirect_to gyms_url, notice: 'Gym was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gym
      @gym = Gym.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gym_params
      params.require(:gym).permit(:number, :rpa, :microregion, :cnes, :name, :adress, :bairro, :phone, :latitude, :longitude, :hour, :rating)
    end
end
