class MsColumnTypesController < ApplicationController
  before_action :set_ms_column_type, only: [:show, :edit, :update, :destroy]

  # GET /ms_column_types
  # GET /ms_column_types.json
  def index
    @ms_column_types = MsColumnType.all
  end

  # GET /ms_column_types/1
  # GET /ms_column_types/1.json
  def show
  end

  # GET /ms_column_types/new
  def new
    @ms_column_type = MsColumnType.new
  end

  # GET /ms_column_types/1/edit
  def edit
  end

  # POST /ms_column_types
  # POST /ms_column_types.json
  def create
    @ms_column_type = MsColumnType.new(ms_column_type_params)

    respond_to do |format|
      if @ms_column_type.save
        format.html { redirect_to @ms_column_type, notice: 'Ms column type was successfully created.' }
        format.json { render :show, status: :created, location: @ms_column_type }
      else
        format.html { render :new }
        format.json { render json: @ms_column_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ms_column_types/1
  # PATCH/PUT /ms_column_types/1.json
  def update
    respond_to do |format|
      if @ms_column_type.update(ms_column_type_params)
        format.html { redirect_to @ms_column_type, notice: 'Ms column type was successfully updated.' }
        format.json { render :show, status: :ok, location: @ms_column_type }
      else
        format.html { render :edit }
        format.json { render json: @ms_column_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ms_column_types/1
  # DELETE /ms_column_types/1.json
  def destroy
    @ms_column_type.destroy
    respond_to do |format|
      format.html { redirect_to ms_column_types_url, notice: 'Ms column type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ms_column_type
      @ms_column_type = MsColumnType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ms_column_type_params
      params.require(:ms_column_type).permit(:name, :description, :prefix, :rails_types_id)
    end
end
