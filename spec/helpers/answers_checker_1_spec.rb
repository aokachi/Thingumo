require 'rails_helper'

RSpec.describe AnswersChecker_1 do
  it '入力サジェスト機能で使用した日本語版Wikipediaのページタイトルのdumpファイルに対して検索を行い、入力内容と一致する語が収録されているかチェックする' do
    checker = AnswersChecker_1.new
    expect(checker.included?("機動戦士ガンダム")).to be true
    expect(checker.included?("CR2032")).to be false
  end
end
