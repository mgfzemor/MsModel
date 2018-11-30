class ForeignKeysController < ApplicationController
  before_action :set_foreign_key, only: [:show, :edit, :update, :destroy]

  # GET /foreign_keys
  # GET /foreign_keys.json
  def index
    @foreign_keys = ForeignKey.all
  end

  # GET /foreign_keys/1
  # GET /foreign_keys/1.json
  def show
  end

  # GET /foreign_keys/new
  def new
    @foreign_key = ForeignKey.new
  end

  # GET /foreign_keys/1/edit
  def edit
  end

  # POST /foreign_keys
  # POST /foreign_keys.json
  def create
    @foreign_key = ForeignKey.new(foreign_key_params)
    @table = Table.find(@foreign_key.source_table)

    respond_to do |format|
      if @foreign_key.save
        format.html { redirect_to @table, notice: 'Foreign key was successfully created.' }
        format.json { render :show, status: :created, location: @table }
      else
        format.html { render :new }
        format.json { render json: @foreign_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foreign_keys/1
  # PATCH/PUT /foreign_keys/1.json
  def update
    respond_to do |format|
      if @foreign_key.update(foreign_key_params)
        format.html { redirect_to @foreign_key, notice: 'Foreign key was successfully updated.' }
        format.json { render :show, status: :ok, location: @foreign_key }
      else
        format.html { render :edit }
        format.json { render json: @foreign_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foreign_keys/1
  # DELETE /foreign_keys/1.json
  def destroy
    @foreign_key.destroy
    respond_to do |format|
      format.html { redirect_to foreign_keys_url, notice: 'Foreign key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foreign_key
      @foreign_key = ForeignKey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def foreign_key_params
      params.require(:foreign_key).permit(:source_column, :source_table, :target_column, :target_table)
    end
end
