class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "ppp", password: "", except: [:index, :show]
  
  def new
    @article = Article.new
  end
  
  def create
    @article=Article.new(article_params)
    
    if @article.save
      redirect_to article_path(:id=>@article.to_param)
    else
      render :new
    end
    
  #  puts "*"*30  
  #  puts @article
  #  puts "*"*30
  
  end
  
  def show
    @article_test = Article.find(params[:id])
  end
  
  def index
    @articles=Article.all
  end
  
  def edit
    @article=Article.find(params[:id])
  end 
  
  def update
    @article = Article.find(params[:id])
  
    if @article.update(article_params)
      redirect_to article_path(:id=>@article.to_param)
    else 
      render 'edit'
    end
  end
  
  def destroy
    @article=Article.find(params[:id])
    @article.destroy
    
    redirect_to articles_path
  end
  
  private
  def article_params
  
  return  params.require(:article).permit(:title,:text)
    
  #  params.each do |key,value|
   #   puts "*"*30
   #   puts key.to_s+"  "+value.to_s
   #   puts "*"*30
   # end
    
  end
end
