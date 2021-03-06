class ProductosController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:confirmation, :failure]
  before_action :set_producto, only: [:show, :edit, :update, :destroy]
  
  def index
    @productos = Producto.all

  end
  
  def pay

    @producto = Producto.find(params[:id])
    @payment = Payment.create

    @payment.order_id = @payment.id.to_s + SecureRandom.random_number(10).to_s
    @payment.session_id = SecureRandom.random_number(10)
    @payment.amount = @producto.price
    @payment.save

    @tbk_url_cgi = "http://186.64.122.15/cgi-bin/lanzarini/tbk_bp_pago.cgi"
    @tbk_tipo_transaccion = "TR_NORMAL"
    @tbk_url_exito = "http://jacobo.beerly.cl/productos/success"
    @tbk_url_fracaso = "http://jacobo.beerly.cl/productos/failure"

  end
  
  def confirmation
    logger.info "ola ke ase"
    render text: "ACEPTADO"
  end
  
  def failure
    logger.info "plipli"
  end
  
  # GET /productos
  # GET /productos.json


  # GET /productos/1
  # GET /productos/1.json
  def show
  end

  
  # GET /productos/new
  def new
    @producto = Producto.new
  end

  # GET /productos/1/edit
  def edit
  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = Producto.new(producto_params)

    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto was successfully created.' }
        format.json { render :show, status: :created, location: @producto }
      else
        format.html { render :new }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1
  # PATCH/PUT /productos/1.json
  def update
    respond_to do |format|
      if @producto.update(producto_params)
        format.html { redirect_to @producto, notice: 'Producto was successfully updated.' }
        format.json { render :show, status: :ok, location: @producto }
      else
        format.html { render :edit }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto.destroy
    respond_to do |format|
      format.html { redirect_to productos_url, notice: 'Producto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:name, :price)
    end
end
