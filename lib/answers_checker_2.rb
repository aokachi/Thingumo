class AnswersChecker_2
  def initialize(text, answer)
    @text = text
    @answer = answer
    begin
      # Neologd辞書を用いてNatto::MeCabのインスタンスを生成
      @nm = Natto::MeCab.new('-d /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd')
      Rails.logger.info "MeCabの初期化に成功。"
    rescue => e
      Rails.logger.error "MeCabの初期化に失敗。: #{e.message}"
      raise
    end
  end

  def included?
    begin
      # 入力されたテキスト内で名詞が見つかったかどうかを示すブール値（trueまたはfalse）を保持する
      noun_found = false
      # ブール値を保持し、テキスト内の最後の形態素が名詞であるかどうかを示す。初期値はfalseで、解析の過程で最後の形態素が名詞であることが確認された場合にtrueに設定される。
      # 最終的に入力テキストが名詞を含むかどうかを判断する際に使用される。未知語の解析をする場合には、この最後の形態素が名詞であるかどうかで入力内容が名詞かどうかを判定する。
      last_noun = false
      # 形態素解析の各ステップで得られた結果を保持する配列
      # 初期状態では空で、解析を進めるにつれて内容が追加されていく
      parse_results = []

      # @nm.parse(@text)は、インスタンス変数@textに格納されたテキストをMeCabで形態素解析するメソッド呼び出しを表す。このメソッドは、与えられたテキストを形態素に分割し、それぞれの形態素に対して品詞情報などの解析結果を生成する。
      # do |n| ... endは@nm.parse(@text)メソッドによって各形態素に対する処理をブロック内で定義する。ここで|n|は、解析された各形態素を表すブロック変数。
      @nm.parse(@text) do |n|
        # 形態素分割の結果をログに記録
        Rails.logger.info "形態素分割: #{n.surface}, 品詞: #{n.feature.split(',')[0]}"

        # Neologdに確認した結果をログに記録
        Rails.logger.info "Neologd確認結果: #{n.is_nor? ? 'Neologd辞書内に存在する' : 'Neologd辞書内に存在しない'}"

        # 解析結果を配列に格納
        parse_results << n

        # 最後の名詞の有無をチェック
        last_noun = true if n.feature.split(',').first == '名詞'
      end

      # 最後の形態素が名詞かどうかに基づいて判断
      noun_found = last_noun

      # 各形態素の解析結果をログに出力
      parse_results.each do |n|
        Rails.logger.info "形態素解析結果: 表層形: #{n.surface}, 品詞: #{n.feature.split(',')[0]}"
      end

      # 最終的な解析結果をログに出力
      Rails.logger.info "形態素解析の最終結果、#{@text}は#{noun_found ? '名詞を含む' : '名詞を含まない'}"

      unless noun_found
        @answer.update(pending: true)
        Rails.logger.info "回答が名詞を含まないため、pendingカラムをtrueに更新しました。"
      end

      # 名詞が見つかったかどうかの結果を返す
      noun_found
    rescue => e
      Rails.logger.error "形態素解析中にエラーが発生: #{e.message}"
      false
    end
  end
end
