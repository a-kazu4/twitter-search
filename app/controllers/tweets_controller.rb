class TweetsController < ApplicationController
  def search
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      # config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      # config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.consumer_key = 'l4NYvQxaziXa7plb42Cd3kho1'
      config.consumer_secret = 'wRYKWTJXUZ6yU2f2X7aAlTIHhnzTn4FnOGBsoDrRASUTL18y3v'
    end
    @tweets = []
    since_id = nil
    # 検索ワードが存在していたらツイートを取得
    if params[:keyword].present?
      # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
      tweets = client.search(params[:keyword], count: 10, result_type: "recent", exclude: "retweets", since_id: since_id)
      # 取得したツイートをモデルに渡す
      tweets.take(10).each do |tw|
        tweet = Tweet.new(tw.created_at, tw.text)
        @tweets << tweet
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweets } # jsonを指定した場合、jsonフォーマットで返す
    end
  end
end
