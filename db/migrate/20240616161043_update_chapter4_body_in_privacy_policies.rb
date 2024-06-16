class UpdateChapter4BodyInPrivacyPolicies < ActiveRecord::Migration[5.2]
  def up
    PrivacyPolicy.where(id: 1).update(
      Chapter4_body: '当社は，利用目的が変更前と関連性を有すると合理的に認められる場合に限り，個人情報の利用目的を変更するものとします。利用目的の変更を行った場合には，変更後の目的について，当社所定の方法により，ユーザーに通知し，または本ウェブサイト上に公表するものとします。'
    )
  end
end
