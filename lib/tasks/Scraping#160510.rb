class Scraping < ApplicationController
  def self.scrape
    require 'mechanize'
    @keywords = Keyword.all
    @keywords.each do |keyword|
      @url = "http://auctions.search.yahoo.co.jp/search?n=100&p=#{keyword.word}"
      searchLink(@url,0)
    end
  end
  def self.searchLink(url,depth)
    @agent = Mechanize.new
    @page = @agent.get(url + "&b=#{depth * 100 + 1}")
    @elements = @page.search('.a1wrp h3 a')
    @elements.each do |element|
      @link = element.get_attribute('href').to_s
      @rIdx = @link.rindex("/")
      @auctionID = @link[@rIdx + 1..-1]
      createProduct(@auctionID)
    end

    @agent = Mechanize.new
    @page = @agent.get(url + "&b=#{depth * 100 + 1}")
    @next = @page.at(".next a")
    if @next
      searchLink(url,depth + 1)
    end
  end

  def self.createProduct(auctionID)
    @url = "http://auctions.yahoo.co.jp/jp/auction/#{auctionID}"
    @agent = Mechanize.new
    @page = @agent.get(@url)
    @product = Product.where("auction_id = '#{auctionID}'").first_or_initialize

    @remain_number = @page.at('.Count__count--sideLine .Count__number')
    @remain_unit = @page.at('.Count__count--sideLine .Count__number .Count__unit')
    puts "AuctionID:" + auctionID
    if @remain_number
      @title = @page.at(".ProductTitle__text")
      if @title
        @product.title = @title.inner_text[0..254].delete("\n")
      else
        puts "タイトルなし！"
      end
      @details = @page.search(".ProductDetail__description")

      @product.status = @details[0].inner_text[1..-1]
      @product.start_date = @details[2].inner_text
      @product.end_date = @details[3].inner_text
      @product.start_price = @details[10].inner_text[1..-2].delete(",").to_i

      @bit = @page.at(".Count__number")
      if @bit
        @product.bit = @bit.inner_text.to_i
      else
        puts "入札数なし！"
      end

      @exhibitor_name = @page.at(".Seller__name")
      if @exhibitor_name
        @product.exhibitor_name = @exhibitor_name.inner_text
      else
        puts "出品者名なし！"
      end

      @exhibitor_evaluation = @page.at(".Seller__ratingSum")
      if @exhibitor_evaluation
        @product.exhibitor_evaluation = @exhibitor_evaluation.inner_text.to_i
      else
        puts "出品者評価なし！"
      end

      @product.auction_id = auctionID

      @currentPrice = @page.at(".Price--current .Price__body .Price__value")
      if @currentPrice
        @product.current_price = @currentPrice.inner_text[0..@currentPrice.inner_text.index("円")-1].delete(",").to_i
      end
      @promptPrice = @page.at(".Price--buynow .Price__body .Price__value")
      if @promptPrice
        @product.prompt_decision_price = @promptPrice.inner_text[0..@promptPrice.inner_text.index("円")-1].delete(",").to_i
      end
      @remain_number = @remain_number.inner_text
      @remain_unit = @remain_unit.inner_text
      @remain_num_idx = @remain_number.index("日") ? @remain_number.index("日") - 1 : @remain_number.index("時間") ? @remain_number.index("時間") - 1 : @remain_number.index("分") ? @remain_number.index("分") - 1 : @remain_number.index("秒") - 1
      @product.remaining_time = @remain_number[0..@remain_num_idx] + @remain_unit[0..1]
      @product.save
    else
      @product.destroy
    end
  end
end