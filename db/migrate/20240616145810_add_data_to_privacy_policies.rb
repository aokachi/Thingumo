class AddDataToPrivacyPolicies < ActiveRecord::Migration[5.2]
  def change
    PrivacyPolicy.create(Chapter1: '第1条（個人情報）', Chapter2: '第2条（個人情報の収集方法）', Chapter3: '第3条（個人情報を収集・利用する目的）', Chapter4: '第4条（利用目的の変更）', Chapter5: '第5条（個人情報の第三者提供）', Chapter6: '第6条（個人情報の開示）', Chapter7: '第7条（個人情報の訂正および削除）', Chapter8: '第8条（個人情報の利用停止等）', Chapter9: '第9条（プライバシーポリシーの変更）')
  end
end