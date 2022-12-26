class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]


  def index
    @articles = Article.all

  end

  def show
    @article = Article.find(params[:id])

    user_id = @article.user_id


    @user = User.find(user_id)

  end

  def new
      @article = Article.new
  end

  def create

    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to @article, notice: "Article saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: "Article updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other, notice: "Article deleted."
    
  end

  
  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

end
