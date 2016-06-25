class KeywordsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @keyword = Keyword.new
    @keyword.word = keyword_params[:keyword]
    @keyword.group_id = @group.id
    @keyword.save
    redirect_to("/groups/#{params[:group_id]}")
  end

  def index
    @keyword = Keyword.new
    @keywords = Group.find(params[:id]).keywords
    @products = Array.new
    @keywords.each do |keyword|
      @products.concat(keyword.products)
    end
  end

  def update
    @keyword = Keyword.find(params[:id])
    if params[:keyword_correction]
      @keyword.word = params[:text]
      @keyword.save
    else
      @keyword.destroy
    end
    redirect_to("/groups/#{params[:group_id]}")
  end

  private
  def delete_params
    params.require(:params).permit(:id)
  end
  def keyword_params
    params.require(:params).permit(:keyword)
  end
end
