require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe "QUESTION #create" do
    before do
      @user = FactoryBot.create(:user)
      @question = FactoryBot.create(:question)
      sign_in @user # Deviseのヘルパーメソッドを使用してユーザーをサインイン状態にする
    end

    context "有効な回答の場合" do
      it "回答を保存してリダイレクトする" do
        expect {
          question :create, params: { question_id: @question.id, answer: { text: "有効な回答" } }
        }.to change(Answer, :count).by(1)
        expect(response).to redirect_to @question
      end
    end

    context "無効な回答の場合" do
      it "回答を保存せずにリダイレクトする" do
        expect {
          question :create, params: { question_id: @question.id, answer: { text: "" } } # 無効な回答
        }.not_to change(Answer, :count)
        expect(flash[:alert]).to be_present
        expect(response).to redirect_to @question
      end
    end
  end

  describe "QUESTION #confirm" do
    before do
      @user = FactoryBot.create(:user)
      @question = FactoryBot.create(:question, user: @user)
      @answer = FactoryBot.create(:answer, question: @question, user: @user)
      sign_in @user
    end

    it "回答を正解としてマークし、リダイレクトする" do
      question :confirm, params: { question_id: @question.id, answer_id: @answer.id }
      
      @answer.reload
      @user.reload
      @question.reload

      expect(@answer.is_selected_correct_answer).to be true
      expect(@question.is_resolved).to be true
      expect(@question.resolved_user_id).to eq(@user.id)
      expect(@user.total_points).to eq(10)
      expect(response).to have_http_status(:success)
    end
  end
end
