class Tweet
  # プロパティの設定
  attr_accessor :name, :text

  def initialize(name, text)
    @name = name
    @text = text
  end
end
