class GroupsController < ApplicationController
    def index
    @groups = Group.all
  end

  def create
    @group = Group.new
    @group.name = create_params[:name]
    @group.save
    redirect_to(index_path)
  end

  def show
    @group = Group.find(params[:id])
    @keyword = Keyword.new
    @keywords = @group.keywords
    @products = Array.new
    @keyword_ids = ""
    @where_sql = ""
    @keywords.each do |keyword|
      @where_sql += keyword.id.to_s + ","
    end
    @where_sql = @where_sql[0..-2]

    @sort_array = Array.new
    @products = Product.where("keyword_id in (#{@where_sql})")
  end

  def show_with_conditions
    @group = Group.find(params[:id])
    @keyword = Keyword.new
    @keywords = @group.keywords
    @products = Array.new
    @keyword_ids = ""
    @where_sql = "keyword_id in ("
    @keywords.each do |keyword|
      @where_sql += keyword.id.to_s + ","
    end
    @where_sql = @where_sql[0..-2] + ")"

    @sort_array = Array.new
    @sort_sql = ""
    @conditions = params[:conditions]
    @condition1 = @conditions[:condition1]
    @condition2 = @conditions[:condition2]
    @condition3 = @conditions[:condition3]
    @except_bit = @conditions[:except_bit].to_i
    logger.debug("condition1:" + @condition1.to_s)
    logger.debug("condition2:" + @condition2.to_s)
    logger.debug("condition3:" + @condition3.to_s)
    logger.debug("except_bit:" + @except_bit.to_s)
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

    @except_bit_sql = ""
    if @except_bit == 1
      @except_bit_sql = "bit > 0"
    end
    logger.debug("where_sql:" + @where_sql)
    logger.debug("sort_sql:" + @sort_sql)
    if @sort_sql.strip == ""
      @products = Product.where(@where_sql).where(@except_bit_sql)
    else
      @products = Product.where(@where_sql).where(@except_bit_sql).order(@sort_sql)
    end

    render :action => "show"
  end

  def scrape
    @group = Group.find(params[:id])
    @group.keywords.each do |keyword|
      keyword.products.delete_all
    end
    Scraping.scrape(@group.keywords)
    redirect_to("/groups/#{params[:id]}")
  end

private
  def create_params
    params.require(:params).permit(:name)
  end
end
