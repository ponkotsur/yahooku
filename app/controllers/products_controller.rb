class ProductsController < ApplicationController
  def index
    @keyword = Keyword.new
    @keywords = Group.find(params[:id]).keywords
    @products = Array.new
    @keywords.each do |keyword|
      @products.concat(keyword.products)
    end
  end

  def index_with_conditions
    index
    @sort_array = Array.new
    @sort_sql = ""
    @condition1 = index_params[:condition1]
    @condition2 = index_params[:condition2]
    @condition3 = index_params[:condition3]
    @except_bit = index_params[:except_bit].to_i
    if @condition1 != ""
      @sort_array.push(@condition1)
    end
    if @condition2 != ""
      @sort_array.push(@condition2)
    end
    if @condition3 != ""
      @sort_array.push(@condition3)
    end
    @sort_array.each_with_index do |condition,idx|
      @sort_sql += condition.to_s + ","
    end
    @sort_sql = @sort_sql[0..-2]

    @where_sql = ""
    if @except_bit == 1
      @where_sql = "bit > 0"
    end

    if @where_sql != "" && @sort_sql != ""
      @products = Product.where(@where_sql).order(@sort_sql)
    elsif @where_sql != ""
      @products = Product.where(@where_sql)
    elsif @sort_sql != ""
      @products = Product.order(@sort_sql)
    else
      @products = Product.all
    end

    render :action => "index"
  end

  def update
  Scraping.scrape
    redirect_to index_path
  end
private
  def index_params
    params.require(:params).permit(:mylist_id,:condition1,:condition2,:condition3,:except_bit)
  end
end
