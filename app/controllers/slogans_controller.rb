class SlogansController < ApplicationController
  layout "admin"
  before_filter :check_admin

  def index
    @slogans = Slogan.all
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @slogan = Slogan.find(params[:id])
  end

  # GET /news/new
  def new
    @slogan = Slogan.new
  end

  # GET /news/1/edit
  def edit
    @slogan = Slogan.find(params[:id])
  end

  # POST /news
  # POST /news.json
  def create
    @slogan = Slogan.new(slogan_params)

    respond_to do |format|
      if @slogan.save
        format.html { redirect_to slogans_path, notice: 'Slogan was successfully created.' }
        format.json { render :show, status: :created, location: @slogan }
      else
        format.html { render :new }
        format.json { render json: @slogan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    @slogan = Slogan.find(params[:id])
    respond_to do |format|
      if @slogan.update(slogan_params)
        format.html { redirect_to slogans_url, notice: 'Slogan was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @slogan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @slogan = Slogan.find(params[:id])
    @slogan.destroy
    respond_to do |format|
      format.html { redirect_to slogans_url, notice: 'Slogan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def slogan_params
      params.require(:slogan).permit(:author, :content)
    end
end
