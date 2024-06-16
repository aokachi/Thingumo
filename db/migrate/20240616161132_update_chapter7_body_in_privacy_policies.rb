class UpdateChapter7BodyInPrivacyPolicies < ActiveRecord::Migration[5.2]
  def up
    PrivacyPolicy.where(id: 1).update(
      Chapter7_body: 'ユーザーは，当社の保有する自己の個人情報が誤った情報である場合には，当社が定める手続きにより，当社に対して個人情報の訂正，追加または削除（以下，「訂正等」といいます。）を請求することができます。'
    )
  end
end
