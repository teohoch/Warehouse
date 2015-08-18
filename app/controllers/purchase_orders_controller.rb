class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  include ApplicationHelper

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
  end

  # GET /purchase_orders/new
  def new
    @purchase_order = PurchaseOrder.new
  end

  # GET /purchase_orders/1/edit
  def edit
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create

    #TODO Change the way the total cost is calculated, currently is calculated client-side, move to server side

    provider_id = params[:purchase_order][:provider_id]
    items = params[:purchase_order][:item_purchase_orders_attributes]
    clean_items = Array.new
    items_success = Array.new
    error = false

    items.each do |item|
      if not to_boolean(item[1][:_destroy]) and item[1][:amount].to_i>0
        clean_items.push(item[1])
      end
    end

    if clean_items.length > 0
      user_id = current_user.id
      provider_id = params[:purchase_order][:provider_id]
      params[:purchase_order][:TotalAmount].slice!(0)
      total_amount = params[:purchase_order][:TotalAmount].to_i

      @purchase_order = PurchaseOrder.new(:user_id => user_id, :provider_id => provider_id, :TotalAmount => total_amount)



      if @purchase_order.save
        clean_items.each do |citem|
          item = ProviderArticle.find(citem[:provider_article_id]).provider_article
          amount = citem[:amount].to_i

          item_total_amount = citem[:total_price]
          item_total_amount.slice!(0)
          item_total_amount = item_total_amount.to_i

          new_item = ItemPurchaseOrder.new(:provider_article_id => item.id, :purchase_order_id => @purchase_order.id,
                                           :amount => amount, :container_price => item.container_price,
                                           :unit_price => item.unit_price,
                                           :units_per_container => item.units_per_container,
                                           :total_price => item_total_amount)
          local_success = new_item.save
          id_item = local_success ? new_item.id : nil
          items_success.push([local_success,id_item])
        end
      end
      overall_success = true
      items_success.each do |check|
        overall_success = overall_success and check
      end
      if not overall_success
        @purchase_order.destroy
      end

    else
      flash_message(:error, "La orden de compra debe tener por lo menos 1 (un) elemento.")
      error = true
    end

    respond_to do |format|
      if not error
        flash_message(:success, "Orden de compra creada con exito")
        format.html { redirect_to @purchase_order}
      else
        format.html { render :new}
      end

    end

  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    all_articles = params[:purchase_order][:item_purchase_orders_attributes]

    # Separate articles to be deleted, from the rest
    workable_articles = Array.new()
    all_articles.each do |key, article|
      if article[:_destroy] == "false"
        workable_articles.push(article)
      else
        if article[:id]
          ItemPurchaseOrder.find(article[:id]).destroy()
        end
      end
    end


    # Calculate the total cost of the Purchase Order
    total_cost = 0
    for item in workable_articles
      total_cost = total_cost + ProviderArticle.find(item[:provider_article_id]).container_price * item[:amount].to_i
    end
    # Update the total cost of the Purchase Order
    @purchase_order.update(:TotalAmount => total_cost)


  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:user_id, :provider_id, :SubmitDate, :TotalAmount)
    end
end
