class SermonsController < ApplicationController
  
  def index
    @sermon = Sermon.where("Date >= :today", {today: Date.today}).order(Date: :asc).limit(1).first


    url = esv_url @sermon.Passage
    @text = Net::HTTP.get(URI.parse(url)).html_safe
    
    respond_to do |format|
      format.html
    end
    
    if user_signed_in?
      send_email(@sermon, @text)
    else
      flash[:notice] = 'User not logged in.'
    end
  end

  def esv_url passage
    query_params = { :key => 'IP', #esv_key,
                     :passage => passage.gsub(/ /, '+'),
                     'include-headings' => false,
                     'include-verse-numbers' => false,
                     'include-footnotes' => false,
                     'include-footnote-links' => false,
                     'include-audio-link' => false}

    query = query_params.map{ |k, v| "#{k}=#{v}" }.join('&')
    "http://www.esvapi.org/v2/rest/passageQuery?#{query}"
  end



  def new
    @sermon = Sermon.new
  end

  def create

  end

  # def show
  #   @sermon = Sermon.all
  # end

  def send_email (sermon, text)
    @sermon = sermon
    @text = text
      @user = current_user
      MyMailer.sermon_email(@user,@sermon,@text).deliver_later
  end
end
