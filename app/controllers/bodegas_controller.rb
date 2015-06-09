class BodegasController < ApplicationController
  before_action :set_bodega, only: [:show, :edit, :update, :destroy]

  # GET /bodegas
  # GET /bodegas.json
  def index
    @bodegas = Bodega.all
  end

  # GET /bodegas/1
  # GET /bodegas/1.json
  def show
  end

  # GET /bodegas/new
  def new
    @bodega = Bodega.new
  end

  # GET /bodegas/1/edit
  def edit
  end

  # POST /bodegas
  # POST /bodegas.json
  def create
    @bodega = Bodega.new(bodega_params)

    respond_to do |format|
      if @bodega.save
        format.html { redirect_to @bodega, notice: 'La bodega fue creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: @bodega }
      else
        format.html { render :new }
        format.json { render json: @bodega.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bodegas/1
  # PATCH/PUT /bodegas/1.json
  def update
    respond_to do |format|
      if @bodega.update(bodega_params)
        format.html { redirect_to @bodega, notice: 'La bodega fue actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @bodega }
      else
        format.html { render :edit }
        format.json { render json: @bodega.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bodegas/1
  # DELETE /bodegas/1.json
  def destroy
    @bodega.destroy
    respond_to do |format|
      format.html { redirect_to bodegas_url, notice: 'La bodega fue elimnada satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bodega
      @bodega = Bodega.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bodega_params
      params.require(:bodega).permit(:name, :location, :description)
    end
end
