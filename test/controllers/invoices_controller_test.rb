require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice" do
    assert_difference('Invoice.count') do
      post :create, invoice: { num_factura: @invoice.num_factura, payment_date: @invoice.payment_date, payment_deadline: @invoice.payment_deadline, provider_id: @invoice.provider_id, purchase_order_id: @invoice.purchase_order_id, received_date: @invoice.received_date, state: @invoice.state, user_id: @invoice.user_id }
    end

    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should show invoice" do
    get :show, id: @invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invoice
    assert_response :success
  end

  test "should update invoice" do
    patch :update, id: @invoice, invoice: { num_factura: @invoice.num_factura, payment_date: @invoice.payment_date, payment_deadline: @invoice.payment_deadline, provider_id: @invoice.provider_id, purchase_order_id: @invoice.purchase_order_id, received_date: @invoice.received_date, state: @invoice.state, user_id: @invoice.user_id }
    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, id: @invoice
    end

    assert_redirected_to invoices_path
  end
end
