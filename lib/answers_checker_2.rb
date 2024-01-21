class AnswersChecker_2
  def initialize(text)
    @text = text
  end

  def included?
    dict_path = "/usr/lib/mecab/dic/mecab-ipadic-neologd"
    # すべての辞書ファイルを検索対象にする
    result = `grep -r #{Shellwords.escape(@text)} #{dict_path}`
    !result.empty?
  end
end