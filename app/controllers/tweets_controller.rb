class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    
  end


def search
  @tweets = Tweet.all
  if params[:search].present?
    search = "%#{params[:search]}%"
    @tweets = @tweets.joins(:user)
                     .where("tweets.name LIKE :s OR tweets.about LIKE :s", s: search)
  end
end






  def region
  @region = params[:region]

  # 英語キー → 漢字名マッピング
  region_names = {
    "hokkaido" => "北海道",
    "tohoku"   => "東北",
    "kanto"    => "関東",
    "tyubu"    => "中部",
    "kinki"    => "近畿",
    "chugoku"  => "中国",
    "shikoku"  => "四国",
    "kyushu"   => "九州",
    "okinawa"  => "沖縄"
  }

  @region_name = region_names[@region] || @region
  @tweets = Tweet.where(region: @region)
end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    
    if tweet.save
      redirect_to action: "index"
    else
      redirect_to action: "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to action: "show", id: tweet.id
    else
      redirect_to action: "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private

def tweet_params
  params.require(:tweet).permit(:name, :price, :about, :image, :overall, :region)
end

  def ensure_admin
    unless current_user.admin?
      redirect_to tweets_path, alert: "権限がありません"
    end
  end
end
