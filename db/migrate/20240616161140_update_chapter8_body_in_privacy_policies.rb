class UpdateChapter8BodyInPrivacyPolicies < ActiveRecord::Migration[5.2]
  def up
    PrivacyPolicy.where(id: 1).update(
      Chapter8_body: '当社は，本人から，個人情報が，利用目的の範囲を超えて取り扱われているという理由，または不正の手段により取得されたものであるという理由により，その利用の停止または消去（以下，「利用停止等」といいます。）を求められた場合には，遅滞なく必要な調査を行います。'
    )
  end
end
