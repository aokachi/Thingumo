class UpdateChapter5BodyInPrivacyPolicies < ActiveRecord::Migration[5.2]
  def up
    PrivacyPolicy.where(id: 1).update(
      Chapter5_body: '当社は，次に掲げる場合を除いて，あらかじめユーザーの同意を得ることなく，第三者に個人情報を提供することはありません。ただし，個人情報保護法その他の法令で認められる場合を除きます。'
    )
  end
end
