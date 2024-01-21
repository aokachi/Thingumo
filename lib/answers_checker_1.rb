class AnswersChecker_1
  def initialize
    file_path = Rails.root.join('lib', 'assets', 'jawiki-20240101-all-titles-in-ns0.txt')
    @titles = File.readlines(file_path).map(&:chomp)
  end

  def included?(query)
    @titles.include?(query)
  end
end