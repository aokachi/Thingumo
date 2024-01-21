class AnswersChecker_3
  def initialize(text)
    @text = text
    @nm = Natto::MeCab.new
  end

  def included?
    @nm.parse(@text) do |n|
      return true if n.feature.split(',').first == '名詞'
    end
    false
  end
end