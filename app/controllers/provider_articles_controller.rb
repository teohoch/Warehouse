class ProviderArticlesController < ApplicationController
  include ApplicationHelper
  before_action :set_provider_article, only: [:show, :edit, :update, :destroy]

  # GET /provider_articles
  # GET /provider_articles.json
  def index
    @provider_articles = CurrentProviderArticle.where(:enabled => true)
  end

  # GET /provider_articles/1
  # GET /provider_articles/1.json
  def show
  end

  # GET /provider_articles/new
  def new
    @provider_article = ProviderArticle.new
  end

  # GET /provider_articles/1/edit
  def edit
  end

  # POST /provider_articles
  # POST /provider_articles.json
  def create
    @provider_article = ProviderArticle.new(provider_article_params)

    respond_to do |format|
      @provider_article.validity_date = DateTime.now
      if @provider_article.save
        current_created = CurrentProviderArticle.new(:articulo_id => @provider_article.articulo_id, :provider_id => @provider_article.provider_id,:provider_article_id => @provider_article.id, :enabled => true)
        current_created.save

        format.html { redirect_to @provider_article, notice: 'Provider article was successfully created.' }
        format.json { render :show, status: :created, location: @provider_article }
      else
        format.html { render :new }
        format.json { render json: @provider_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provider_articles/1
  # PATCH/PUT /provider_articles/1.json
  def update
    @provider_article = ProviderArticle.new(provider_article_params)
    respond_to do |format|
      @provider_article.validity_date = DateTime.now
      if @provider_article.save
        current = CurrentProviderArticle.where(:articulo_id => @provider_article.articulo_id, :provider_id => @provider_article.provider_id)
        current.first.update_attributes(:provider_article_id => @provider_article.id, :enabled => provider_article_params[:current_enabled])

        format.html { redirect_to @provider_article, notice: 'Disponibilidad de Articulo fue actualizada exitosamente.' }
        format.json { render :show, status: :created, location: @provider_article }
      else
        format.html { render :new }
        format.json { render json: @provider_article.errors, status: :unprocessable_entity }
      end
    end
    # respond_to do |format|
    #   if @provider_article.update(provider_article_params)
    #     format.html { redirect_to @provider_article, notice: 'Provider article was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @provider_article }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @provider_article.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /provider_articles/1
  # DELETE /provider_articles/1.json
  def destroy
    current_provider_article = CurrentProviderArticle.find(params[:current_id])
    current_provider_article.enabled = false
    if current_provider_article.save
      flash_message(:success, 'Disponibilidad eliminada con exito')
    end
    respond_to do |format|
      format.html { redirect_to provider_articles_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider_article
      @provider_article = ProviderArticle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_article_params
      params.require(:provider_article).permit(:provider_id, :articulo_id, :container_price, :unit_price, :units_per_container, :validity_date, :current_enabled)
    end
end
