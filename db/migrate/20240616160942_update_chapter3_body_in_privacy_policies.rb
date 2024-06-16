class UpdateChapter3BodyInPrivacyPolicies < ActiveRecord::Migration[5.2]
  def up
    PrivacyPolicy.where(id: 1).update(
      Chapter3_body: '当社が個人情報を収集・利用する目的は，以下のとおりです。'
    )
  end
end
