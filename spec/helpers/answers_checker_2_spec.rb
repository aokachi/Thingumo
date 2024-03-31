require 'rails_helper'

RSpec.describe AnswersChecker_2 do
  it 'Neologd辞書とMecabを用いて入力情報が名詞かどうか判定する' do
    checker = AnswersChecker_2.new("言語処理学会")
    expect(checker.included?).to be true

    checker = AnswersChecker_2.new("わかりましたか")
    expect(checker.included?).to be false
  end
end
