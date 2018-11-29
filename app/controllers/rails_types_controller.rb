class RailsTypesController < ApplicationController
  before_action :set_rails_type, only: [:show, :edit, :update, :destroy]

  # GET /rails_types
  # GET /rails_types.json
  def index
    @rails_types = RailsType.all
  end

  # GET /rails_types/1
  # GET /rails_types/1.json
  def show
  end

  # GET /rails_types/new
  def new
    @rails_type = RailsType.new
  end

  # GET /rails_types/1/edit
  def edit
  end

  # POST /rails_types
  # POST /rails_types.json
  def create
    @rails_type = RailsType.new(rails_type_params)

    respond_to do |format|
      if @rails_type.save
        format.html { redirect_to @rails_type, notice: 'Rails type was successfully created.' }
        format.json { render :show, status: :created, location: @rails_type }
      else
        format.html { render :new }
        format.json { render json: @rails_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rails_types/1
  # PATCH/PUT /rails_types/1.json
  def update
    respond_to do |format|
      if @rails_type.update(rails_type_params)
        format.html { redirect_to @rails_type, notice: 'Rails type was successfully updated.' }
        format.json { render :show, status: :ok, location: @rails_type }
      else
        format.html { render :edit }
        format.json { render json: @rails_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rails_types/1
  # DELETE /rails_types/1.json
  def destroy
    @rails_type.destroy
    respond_to do |format|
      format.html { redirect_to rails_types_url, notice: 'Rails type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rails_type
      @rails_type = RailsType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rails_type_params
      params.require(:rails_type).permit(:name, :active_size)
    end
end
