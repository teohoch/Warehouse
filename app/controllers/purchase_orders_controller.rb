class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy, :sending]
  load_and_authorize_resource
  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PurchaseOrderPdf.new(@purchase_order, view_context)
        send_data pdf.render, filename: "order_#{@purchase_order}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  # GET /purchase_orders/new
  def new
    @purchase_order = PurchaseOrder.new(:sendLocation => current_user.location, :SubmitDate => Date.today )
  end

  # GET /purchase_orders/1/edit
  def edit
    if @purchase_order.Status != "No Enviada"
      respond_to do |format|
        flash_message(:error, "¡Esta orden de compra ya ha sido enviada al proveedor, no puede ser modificada!")
        format.html { redirect_to @purchase_order}
      end
    else
      @items = @purchase_order.item_purchase_orders

    end
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

      @purchase_order = PurchaseOrder.new(:user_id => user_id, :provider_id => provider_id, :TotalAmount => total_amount, :paymentMethod => params[:purchase_order][:paymentMethod], :sendLocation => params[:purchase_order][:sendLocation])



      if @purchase_order.save
        clean_items.each do |citem|
          item = ProviderArticle.find(citem[:provider_article_id])
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
    if @editable
      all_articles = params[:purchase_order][:item_purchase_orders_attributes]

      # Separate articles to be deleted, from the rest
      # If _destroy flag is set, the article is either ignored or destroyed, depending if it exists.
      workable_articles = Array.new()
      all_articles.each do |key, article|
        if article[:_destroy] == "false"
          if article[:amount].to_i > 0
            workable_articles.push(article)
          else
            if article[:id]
              ItemPurchaseOrder.find(article[:id]).destroy()
            end
          end
        else
          if article[:id]
            ItemPurchaseOrder.find(article[:id]).destroy()
          end
        end
      end

      workable_articles.each do |article|
        item = ProviderArticle.find(article[:provider_article_id])
        article_total_price = item.container_price * article[:amount].to_i
        if article[:id]
          old_article = ItemPurchaseOrder.find(article[:id])
          old_article.update(:provider_article => item,
                             :amount => article[:amount].to_i,
                             :container_price => item.container_price,
                             :unit_price => item.unit_price,
                             :units_per_container => item.units_per_container,
                             :total_price => article_total_price)
        else
          new_item = ItemPurchaseOrder.new(:provider_article_id => item.id,
                                           :purchase_order_id => @purchase_order.id,
                                           :amount => article[:amount].to_i,
                                           :container_price => item.container_price,
                                           :unit_price => item.unit_price,
                                           :units_per_container => item.units_per_container,
                                           :total_price => article_total_price)
          local_success = new_item.save
        end
      end

      # Calculate the total cost of the Purchase Order
      total_cost = 0
      for item in workable_articles
        total_cost = total_cost + ProviderArticle.find(item[:provider_article_id]).container_price * item[:amount].to_i
      end
      # Update the total cost of the Purchase Order
      @purchase_order.update(:TotalAmount => total_cost)

      respond_to do |format|
        flash_message(:success, "Orden de compra actualizada con exito")
        format.html { redirect_to @purchase_order }
      end
    else
      if @purchase_order.Status != "No Enviada"
        respond_to do |format|
          flash_message(:error, "¡Esta orden de compra ya ha sido enviada al proveedor, no puede ser modificada!")
          format.html { redirect_to @purchase_order}
        end
      end
    end
  end

  def sending
    if @editable
      @purchase_order.update(:Status => "Enviada", :SubmitDate => Date.today )
      redirect_to purchase_order_path(@purchase_order, format: :pdf)
    else
      respond_to do |format|
        flash_message(:error, "¡Esta orden de compra ya ha sido enviada al proveedor!")
        format.html { redirect_to @purchase_order}
      end
    end
  end


  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    if @editable
      @purchase_order.destroy
      respond_to do |format|
        format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        flash_message(:error, "¡Esta orden de compra ya ha sido enviada al proveedor! ¡No puede se eliminada!")
        format.html { redirect_to @purchase_order}
      end
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
      @editable = (@purchase_order.Status == "No Enviada")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:user_id, :provider_id, :SubmitDate, :TotalAmount)
    end
end
