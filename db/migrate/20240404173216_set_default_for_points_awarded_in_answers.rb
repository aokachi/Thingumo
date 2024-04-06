class SetDefaultForPointsAwardedInAnswers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :answers, :points_awarded, from: nil, to: false
  end
end
