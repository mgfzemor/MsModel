class PrimaryKeysController < ApplicationController
  before_action :set_primary_key, only: [:show, :edit, :update, :destroy]

  # GET /primary_keys
  # GET /primary_keys.json
  def index
    @primary_keys = PrimaryKey.all
  end

  # GET /primary_keys/1
  # GET /primary_keys/1.json
  def show
  end

  # GET /primary_keys/new
  def new
    @primary_key = PrimaryKey.new
  end

  # GET /primary_keys/1/edit
  def edit
  end

  # POST /primary_keys
  # POST /primary_keys.json
  def create
    @primary_key = PrimaryKey.new(primary_key_params)

    respond_to do |format|
      if @primary_key.save
        format.html { redirect_to @primary_key, notice: 'Primary key was successfully created.' }
        format.json { render :show, status: :created, location: @primary_key }
      else
        format.html { render :new }
        format.json { render json: @primary_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /primary_keys/1
  # PATCH/PUT /primary_keys/1.json
  def update
    respond_to do |format|
      if @primary_key.update(primary_key_params)
        format.html { redirect_to @primary_key, notice: 'Primary key was successfully updated.' }
        format.json { render :show, status: :ok, location: @primary_key }
      else
        format.html { render :edit }
        format.json { render json: @primary_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /primary_keys/1
  # DELETE /primary_keys/1.json
  def destroy
    @primary_key.destroy
    respond_to do |format|
      format.html { redirect_to primary_keys_url, notice: 'Primary key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_primary_key
      @primary_key = PrimaryKey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def primary_key_params
      params.require(:primary_key).permit(:table_id, :column_id)
    end
end
