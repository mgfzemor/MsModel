class ColumnsController < ApplicationController
  before_action :set_column, only: [:show, :edit, :update, :destroy]

  # GET /columns
  # GET /columns.json
  def index
    @columns = Column.all
  end

  # GET /columns/1
  # GET /columns/1.json
  def show
  end

  # GET /columns/new
  def new
    @column = Column.new
  end

  # GET /columns/1/edit
  def edit
    @table = Table.find(@column.tables_id)
  end

  # POST /columns
  # POST /columns.json
  def create
    @column = Column.new(column_params)
    @table = Table.find(@column.tables_id)
    puts '------------'
    puts @table
    respond_to do |format|
      if @column.save
        format.html { redirect_to @table, notice: 'Column was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /columns/1
  # PATCH/PUT /columns/1.json
  def update
    @table = Table.find(@column.tables_id)
    respond_to do |format|
      if @column.update(column_params)
        format.html { redirect_to @table, notice: 'Column was successfully updated.' }
        format.json { render :show, status: :ok, location: @column }
      else
        format.html { render :edit }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /columns/1
  # DELETE /columns/1.json
  def destroy
    @table = Table.find(@column.tables_id)
    @column.destroy
    respond_to do |format|
      format.html { redirect_to @table, notice: 'Column was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def column_params
      params.require(:column).permit(:system_name, :database_name, :nn, :uq, :bin, :un, :zf, :g, :ms_column_types_id, :tables_id)
    end
end
