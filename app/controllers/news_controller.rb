class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  def index
    @news = News.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])
    ReadMessage.create(:user_id => session[:user_name].id, :news_id => params[:id]) if session[:user_name] and params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
  end

  # POST /news
  # POST /news.json
  def create

    params[:news][:name].blank? ? (@news = News.new(params[:news])) : (@news = News.new(params[:news]))
    if session[:user_name].blank?
    @user = User.new
    @user.name = params[:news][:name]
    if @user.save and session[:user_name].blank?
    session[:user_name] = @user
    end
    end
    respond_to do |format|
      if @news.save

        NewsUser.create(:news_id =>@news.id,:user_id => session[:user_name].id)
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end
def clear_cookies
  session[:user_name] = nil
  session[:user_name] = ""
  @news=News.all
  render :action => 'index'
  return
end
  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :ok }
    end
  end

  def notification_refresh
    @user = session[:user_name]
    @messages = @user.unread_news(@user.id)
    render :partial => "/news/notification_refresh"
  end
end
