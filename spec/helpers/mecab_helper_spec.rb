# MeCabとNeologdを用いた形態素解析が正しく機能するか確認する
require 'rails_helper'

RSpec.describe 'MeCab and Neologd' do
  it '正しく形態素解析ができる' do
    begin
      # MeCabのライブラリが利用可能か確認する
      nm = Natto::MeCab.new
    rescue => e
      Rails.logger.error "MeCabの初期化に失敗しました: #{e.message}"
      raise
    end

    # テスト用のテキスト
    text = "猫ミーム"

    # 形態素解析を実行
    results = []
    nm.parse(text) do |n|
      results.push(n.surface)
    end

    # Neologdが正しく使われているかの確認
    expect(results).to include("猫","ミーム")
  end
end
