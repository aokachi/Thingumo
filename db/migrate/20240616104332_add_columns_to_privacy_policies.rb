class AddColumnsToPrivacyPolicies < ActiveRecord::Migration[5.2]
  def change
    add_column :privacy_policies, :Chapter1, :string
    add_column :privacy_policies, :Chapter2, :string
    add_column :privacy_policies, :Chapter3, :string
    add_column :privacy_policies, :Chapter4, :string
    add_column :privacy_policies, :Chapter5, :string
    add_column :privacy_policies, :Chapter6, :string
    add_column :privacy_policies, :Chapter7, :string
    add_column :privacy_policies, :Chapter8, :string
    add_column :privacy_policies, :Chapter9, :string
    add_column :privacy_policies, :Chapter10, :string
  end
end