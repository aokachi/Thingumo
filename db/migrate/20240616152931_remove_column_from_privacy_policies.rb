class RemoveColumnFromPrivacyPolicies < ActiveRecord::Migration[5.2]
  def change
    remove_column :privacy_policies, :text, :text
  end
end
