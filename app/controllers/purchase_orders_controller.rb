class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]

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

    provider_id = params[:purchase_order][:provider_id]
    items = params[:purchase_order][:item_purchase_orders_attributes]
    clean_items = Array.new
    items_success = Array.new

    items.each do |item|
      if not to_boolean(item[1][:_destroy]) and item[1][:amount].to_i>0
        clean_items.push(item[1])
      end
    end

    user_id = current_user.id
    provider_id = params[:purchase_order][:provider_id]
    params[:purchase_order][:TotalAmount].slice!(0)
    total_amount = params[:purchase_order][:TotalAmount].to_i

    @purchase_order = PurchaseOrder.new(:user_id => user_id, :provider_id => provider_id, :TotalAmount => total_amount)

    if @purchase_order.save
      clean_items.each do |citem|
        item = CurrentProviderArticle.find(citem[:provider_article_id]).provider_article
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

    end

    respond_to do |format|
      if @purchase_order.save
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
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
