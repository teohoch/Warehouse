class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update, :destroy, :select_add_multiple_articles, :input_add_multiple_articles]
  load_and_authorize_resource
  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  # GET /providers
  # GET /providers.json
  def index
    @providers = Provider.all
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    @available = CurrentProviderArticle.where(:provider_id => @provider.id, :enabled => TRUE)
  end

  # GET /providers/new
  def new
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to @provider, notice: 'El nuevo proveedor fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to @provider, notice: 'El Proveedor fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'El Proveedor fue actualizado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def select_add_multiple_articles
    @Articulos = Articulo.all
    @Articulos_disponibles = CurrentProviderArticle.where(:provider_id => @provider.id, :enabled => TRUE)
  end

  def input_add_multiple_articles
    @Articulos_to_add = Array.new
    checked_to_add = Array.new
    temp = params[:aval][:check]
    temp.each do |f|
      if f[1] == "true"
        @Articulos_to_add.push(ProviderArticle.new(:provider_id => @provider.id, :articulo_id => f[0]))
      end
    end
  end

  def create_multiple_articles
    items = params[:create][:articulos]

    items.each do |i|
      new_articulo_id = i.first
      new_data = i.second
      pa = ProviderArticle.new(:provider_id => @provider.id, :articulo_id => new_articulo_id, :container_price => new_data[:container_price], :unit_price => new_data[:unit_price], :units_per_container => new_data[:units_per_container], :validity_date => DateTime.now)
      if pa.save
        current_created = CurrentProviderArticle.where(:articulo_id => pa.articulo_id, :provider_id => pa.provider_id)
        if current_created.blank?
          current_created = CurrentProviderArticle.new(:articulo_id => pa.articulo_id, :provider_id => pa.provider_id, :provider_article_id => pa.id, :enabled => TRUE)
          success = current_created.save
        else
          success = current_created.first.update( :provider_article_id => pa.id, :enabled => TRUE)
        end

        if success
          flash_message(:success, ("Se a agregado a la lista de disponibilidad de " << @provider.name.titlecase << " el articulo " << pa.articulo.name.titlecase))
        else
          flash_message(:error, ("No se a podido agregar " << pa.articulo.name.titleize << " a la lista de disponibilidad de " << @provider.name.titlecase))
        end
      end
    end
    respond_to do |format|
      format.html{ redirect_to @provider}
    end
  end

  def select_remove_multiple_articles
    @Articulos_disponibles = CurrentProviderArticle.where(:provider_id => @provider.id, :enabled => TRUE)
  end

  def remove_multiple_articles
    ids_to_remove = params[:aval][:check]
    ids_to_remove.each do |p|
      if p.second
        current = CurrentProviderArticle.find_by_id(p.first)
        if current.update(:enabled => FALSE)
          flash_message(:success, ("Se a eliminado " << current.articulo.name.titlecase << " a la lista de disponibilidad de " << @provider.name.titlecase))
        else
          flash_message(:error, ("No se a podido eliminar " << current.articulo.name.titlecase   << " de la lista de disponibilidad de " << @provider.name.titlecase))
        end
      end
    end

    respond_to do |format|
      format.html{ redirect_to @provider}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :address, :phone, :rut)
    end
end
