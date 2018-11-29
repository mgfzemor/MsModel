class TableTypesController < ApplicationController
  before_action :set_table_type, only: [:show, :edit, :update, :destroy]

  # GET /table_types
  # GET /table_types.json
  def index
    @table_types = TableType.all
  end

  # GET /table_types/1
  # GET /table_types/1.json
  def show
  end

  # GET /table_types/new
  def new
    @table_type = TableType.new
  end

  # GET /table_types/1/edit
  def edit
  
  end

  # POST /table_types
  # POST /table_types.json
  def create
    @table_type = TableType.new(table_type_params)

    respond_to do |format|
      if @table_type.save
        format.html { redirect_to @table_type, notice: 'Table type was successfully created.' }
        format.json { render :show, status: :created, location: @table_type }
      else
        format.html { render :new }
        format.json { render json: @table_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /table_types/1
  # PATCH/PUT /table_types/1.json
  def update
    respond_to do |format|
      if @table_type.update(table_type_params)
        format.html { redirect_to @table_type, notice: 'Table type was successfully updated.' }
        format.json { render :show, status: :ok, location: @table_type }
      else
        format.html { render :edit }
        format.json { render json: @table_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /table_types/1
  # DELETE /table_types/1.json
  def destroy
    @table_type.destroy
    respond_to do |format|
      format.html { redirect_to table_types_url, notice: 'Table type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table_type
      @table_type = TableType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_type_params
      params.require(:table_type).permit(:name, :description, :prefix)
    end
end
