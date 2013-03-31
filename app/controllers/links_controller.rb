class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :set_pot

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @link.pot = current_pot
    @link.user = current_user
    
    respond_to do |format|
      if @link.save
        @link.create_activity :create, owner: current_user
        format.html { redirect_to @link.pot, notice: 'Link wurde hinzugefügt.' }
        format.json { render action: 'show', status: :created, location: @link }
      else
        format.html { render action: 'pots/new' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        @link.create_activity :update, owner: current_user
        format.html { redirect_to @link.pot, flash: {success: 'Link wurde aktualisiert.'} }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:name, :url, :description, :hottiness)
    end
    
    def current_pot
      @current_pot ||= Pot.find(params[:pot_id])
    end
    
    def set_pot
      @pot = current_pot
    end
end
