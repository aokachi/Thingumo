require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe "POST #create" do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post)
      sign_in @user # Deviseのヘルパーメソッドを使用してユーザーをサインイン状態にする
    end

    context "有効な回答の場合" do
      it "回答を保存してリダイレクトする" do
        expect {
          post :create, params: { post_id: @post.id, answer: { text: "有効な回答" } }
        }.to change(Answer, :count).by(1)
        expect(response).to redirect_to @post
      end
    end

    context "無効な回答の場合" do
      it "回答を保存せずにリダイレクトする" do
        expect {
          post :create, params: { post_id: @post.id, answer: { text: "" } } # 無効な回答
        }.not_to change(Answer, :count)
        expect(flash[:alert]).to be_present
        expect(response).to redirect_to @post
      end
    end
  end

  describe "POST #confirm" do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post, user: @user)
      @answer = FactoryBot.create(:answer, post: @post, user: @user)
      sign_in @user
    end

    it "回答を正解としてマークし、リダイレクトする" do
      post :confirm, params: { post_id: @post.id, answer_id: @answer.id }
      
      @answer.reload
      @user.reload
      @post.reload

      expect(@answer.is_selected_correct_answer).to be true
      expect(@post.is_resolved).to be true
      expect(@post.resolved_user_id).to eq(@user.id)
      expect(@user.total_points).to eq(10)
      expect(response).to have_http_status(:success)
    end
  end
end
