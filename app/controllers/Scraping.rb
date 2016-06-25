require 'upsert/active_record_upsert'
require 'parallel'
require 'mechanize'

class Scraping < ApplicationController
  @@basic_url = "http://auctions.search.yahoo.co.jp/search?n=100&p="

  def self.scrape(keywords)
    # # @add_url = "%28"
    # keywords.each do |keyword|
    #   # createProductLite(@url,0)
    #   searchLink(keyword,0)
    #   # @add_keyword = ""
    #   # @separate_keyword = keyword.word.split(" ")
    #   # @array_keyword = Array.new
    #   # @except_keyword = Array.new
    #   # @separate_keyword.each do |element|
    #   #   if element[0] == "-"
    #   #     @except_keyword.push(element)
    #   #   else
    #   #     @array_keyword.push(element)
    #   #   end
    #   # end
    #   # @add_keyword += %q{%28"}
    #   # @array_keyword.each do |key|
    #   #   @add_keyword += key + "+"
    #   # end
    #   # @add_keyword = @add_keyword[0..-2]
    #   # @add_keyword += '"'
    #   # @except_keyword.each do |key|
    #   #   @add_keyword += " " + key
    #   # end
    #   # @add_keyword += "%29"
    #   # @add_url += @add_keyword
    # end
    # # @add_url += "%29"
    # # @url = "http://auctions.search.yahoo.co.jp/search?n=100&p=#{@add_url}"
    # # createProductLite(@url,0)

    # @start_time = Time.now
    # Parallel.each(keywords, in_threads: 1){ |keyword|
    #   searchLink(keyword,0)
    # }
    # @core1_time = Time.now - @start_time
    # @start_time = Time.now
    # Parallel.each(keywords, in_threads: 2){ |keyword|
    #   searchLink(keyword,0)
    # }
    # @core2_time = Time.now - @start_time
    @start_time = Time.now
    Parallel.each(keywords, in_threads: 4){ |keyword|
      searchLink(keyword,0)
    }
    @core4_time = Time.now - @start_time

    # p "core1_time:" + @core1_time.to_s
    # p "core2_time:" + @core2_time.to_s
    p "core4_time:" + @core4_time.to_s
  end
  def self.searchLink(keyword,depth)
    @agent = Mechanize.new
    @url = @@basic_url + keyword.word
    @page = @agent.get(@url + "&b=#{depth * 100 + 1}")
    @elements = @page.search('.a1wrp h3 a')
    @elements.each do |element|
      @link = element.get_attribute('href').to_s
      @rIdx = @link.rindex("/")
      @auctionID = @link[@rIdx + 1..-1]
      createProduct(@auctionID,keyword)
    end

    @agent = Mechanize.new
    @page = @agent.get(@url + "&b=#{depth * 100 + 1}")
    @next = @page.at(".next a")
    if @next
      searchLink(@url,depth + 1)
    end
  end

  def self.createProductLite(url,depth)
    @agent = Mechanize.new
    @page = @agent.get(url + "&b=#{depth * 100 + 1}")
    @elements = @page.search("tr")
    @products = Array.new
    @elements.each do |ele|
      if ele.at(".i")
        @link = ele.at(".a1 a").get_attribute("href")
        @rIdx = @link.rindex("/")
        @auction_id = @link[@rIdx + 1 ..-1].to_s
        @product = Product.where("auction_id = '#{@auction_id}'").first_or_initialize
        @product.title = ele.at(".a1 a").inner_text
        @product.exhibitor_name = ele.search(".a1 .sinfwrp .a4 p a")[ele.search(".a1 .sinfwrp .a4 p a").length - 2].inner_text
        @product.current_price = ele.at(".pr1").child.inner_text.strip[0..-2].delete(",")
        if !ele.at(".pr2 span")
          @product.prompt_decision_price = ele.at(".pr2").inner_text[0..-2].delete(",")
        end
        if !ele.at(".bi span")
          @product.bit = ele.at(".bi a").inner_text
        else
          @product.bit = 0
        end
        @product.auction_id = @auction_id
        @remaining_time = ele.at(".ti").inner_text.to_s
        @strIdx = @remaining_time.index("日") ? @remaining_time.index("日") : @remaining_time.index("時間") ? @remaining_time.index("時間") : @remaining_time.index("分") ? @remaining_time.index("分") : 0
        if  @strIdx != 0
          @product.remaining_time = @remaining_time[0..@strIdx - 1].to_i
          @product.remaining_time_unit = @remaining_time[@strIdx..-1]
        end
        @products.push(@product)
      end
    end
    logger.debug(url + "&b=#{depth * 100 + 1}")
    Product.transaction do
      @products.each do |product|
        product.save!
      end
    end
    @agent = Mechanize.new
    @page = @agent.get(url + "&b=#{depth * 100 + 1}")
    @next = @page.at(".next a")
    if @next
      createProductLite(url,depth + 1)
    end
  end

  def self.createProduct(auctionID,keyword)
    # require 'active_record'
    # config = {
    #   adapter: 'postgresql',
    #   host: 'localhost',
    #   database: 'yahooku_development',
    #   port: 5432,
    #   username: 'root',
    #   password: 'root',
    #   encoding: 'utf8',
    #   timeout: 5000,
    # }

    # ActiveRecord::Base.establish_connection(config)
    # con = ActiveRecord::Base.connection
    # @product = con.execute("select * from products where auction_id = '#{auctionID}'")
    # p @product
    @url = "http://auctions.yahoo.co.jp/jp/auction/#{auctionID}"
    @agent = Mechanize.new
    @page = @agent.get(@url)
    @product = Product.new
    # @product = Product.where("auction_id = '#{auctionID}'").first_or_initialize
    # @product = Product.connection.select("select * from products where auction_id = #{auctionID}")

    @content = @page.at('.Count__count--sideLine .Count__number')
    @remain_number = @content.inner_text if @content
    @content = @page.at('.Count__count--sideLine .Count__number .Count__unit')
    @remain_unit = @content.inner_text if @content
    puts "AuctionID:" + auctionID

    @products = Array.new
    if @remain_number
      @title = @page.at(".ProductTitle__text")
      if @title
        @product.title = @title.inner_text[0..254].delete("\n")
      else
        puts "タイトルなし！"
      end
      @details = @page.search(".ProductDetail__description")
      if @details
        @product.status = @details[0].inner_text[1..-1]
        @product.start_date = @details[2].inner_text
        @product.end_date = @details[3].inner_text
        @product.start_price = @details[10].inner_text[1..-2].delete(",").to_i
      end

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
      # @remain_number = @remain_number.inner_text
      # @remain_unit = @remain_unit.inner_text
      @remain_num_idx = @remain_number.index("日") ? @remain_number.index("日") - 1 : @remain_number.index("時間") ? @remain_number.index("時間") - 1 : @remain_number.index("分") ? @remain_number.index("分") - 1 : @remain_number.index("秒") - 1
      @product.remaining_time = @remain_number[0..@remain_num_idx] + @remain_unit[0..1]
      @product.remaining_time_unit = @remain_number.index("日") ? "日" : @remain_number.index("時間") ? "時間" : @remain_number.index("分") ? "分" : ""
      @product.keyword_id = keyword.id
      # @product.save
      @products.push(@product)
    else
      @product.destroy
    end

    @start_time_transaction = Time.now
    Product.transaction do
      @products.each do |product|
        product.save!
      end
    end
    @time_transaction = Time.now - @start_time_transaction

    # require 'pg'
    # @connection = PG.connect(:host => "localhost", :user => "root", :password => "root", :dbname => "yahooku_development")
    # @start_time_upsert = Time.now
    # Upsert.batch(@connection, :products) do |upsert|
    #   @products.each do |product|
    #     @selector = {:auction_id => product.auction_id}
    #     @setter = { 
    #                 :title => product.title,
    #                 :start_price => product.start_price,
    #                 :current_price => product.current_price,
    #                 :prompt_decision_price => product.prompt_decision_price,
    #                 :start_date => product.start_date,
    #                 :end_date => product.end_date,
    #                 :exhibitor_name => product.exhibitor_name,
    #                 :exhibitor_evaluation => product.exhibitor_evaluation,
    #                 :status => product.status,
    #                 :bit => product.bit,
    #                 :auction_id => product.auction_id,
    #                 :created_at => Time.now,
    #                 :updated_at => Time.now,
    #                 :remaining_time => product.remaining_time,
    #                 :keyword_id => product.keyword_id
    #                 }
    #     upsert.row(@selector,@setter)
    #   end
    # end
    # @time_upsert = Time.now - @start_time_upsert
  end
end