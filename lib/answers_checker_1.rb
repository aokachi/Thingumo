class AnswersChecker_1
  def initialize
    # 日本語版Wikipediaのタイトルが含まれるテキストファイルへのパスを生成する
    file_path = Rails.root.join('lib', 'assets', 'jawiki-20240101-all-titles-in-ns0.txt')
    # テキストファイルの内容を取得する
    @titles = File.readlines(file_path).map(&:chomp)
  end

  def included?(query)
    # テキストファイルの内容を取り出した配列に回答内容が含まれているかチェックする
    @titles.include?(query)
  end
end