class AddColumnsToPrivacyPolicies2 < ActiveRecord::Migration[5.2]
  def change
    add_column :privacy_policies, :Chapter1_body, :string
    add_column :privacy_policies, :Chapter2_body, :string
    add_column :privacy_policies, :Chapter3_body, :string
    add_column :privacy_policies, :Chapter4_body, :string
    add_column :privacy_policies, :Chapter5_body, :string
    add_column :privacy_policies, :Chapter6_body, :string
    add_column :privacy_policies, :Chapter7_body, :string
    add_column :privacy_policies, :Chapter8_body, :string
    add_column :privacy_policies, :Chapter9_body, :string
    add_column :privacy_policies, :Chapter10_body, :string
  end
end
