class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  # GET /items
  # GET /items.json
  def index
    #@items = Item.all
    @list_id=params[:id]
    @lists=List.find(@list_id)
    @items=@lists.items
  end

  # GET /items/1
  # GET /items/1.json
  def back
    @list_id=@item.list_id
    redirect_to :action => 'index', :id => @list_id
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @newListId=@item.list_id
    @newList=List.find(@newListId)
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    else
      respond_to do |format|
        if @item.save
          format.html { redirect_to @item, notice: 'Item was successfully created.' }
          format.json { render :show, status: :created, location: @item }
        else
          format.html { render :new }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @list_id=@item.list_id
    @item.destroy
    redirect_to :action => 'index', :id => @list_id
    #redirect_to '/items?id=', :notice => "Your item has been deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :list_id)
    end
end
