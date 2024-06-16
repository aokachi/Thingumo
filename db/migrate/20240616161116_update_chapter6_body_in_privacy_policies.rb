class UpdateChapter6BodyInPrivacyPolicies < ActiveRecord::Migration[5.2]
  def up
    PrivacyPolicy.where(id: 1).update(
      Chapter6_body: '当社は、本人から個人情報の開示を求められたときは、本人に対し、遅滞なくこれを開示します。ただし、開示することにより次のいずれかに該当する場合は、その全部または一部を開示しないこともあり、開示しない決定をした場合には、その旨を遅滞なく通知します。なお、個人情報の開示に際しては、1件あたり1000円の手数料を申し受けます。'
    )
  end
end
