require 'test_helper'

class ProviderArticlesControllerTest < ActionController::TestCase
  setup do
    @provider_article = provider_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provider_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provider_article" do
    assert_difference('ProviderArticle.count') do
      post :create, provider_article: { articulo_id: @provider_article.articulo_id, container_price: @provider_article.container_price, provider_id: @provider_article.provider_id, unit_price: @provider_article.unit_price, units_per_container: @provider_article.units_per_container, validity_date: @provider_article.validity_date }
    end

    assert_redirected_to provider_article_path(assigns(:provider_article))
  end

  test "should show provider_article" do
    get :show, id: @provider_article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provider_article
    assert_response :success
  end

  test "should update provider_article" do
    patch :update, id: @provider_article, provider_article: { articulo_id: @provider_article.articulo_id, container_price: @provider_article.container_price, provider_id: @provider_article.provider_id, unit_price: @provider_article.unit_price, units_per_container: @provider_article.units_per_container, validity_date: @provider_article.validity_date }
    assert_redirected_to provider_article_path(assigns(:provider_article))
  end

  test "should destroy provider_article" do
    assert_difference('ProviderArticle.count', -1) do
      delete :destroy, id: @provider_article
    end

    assert_redirected_to provider_articles_path
  end
end
