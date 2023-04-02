class InquiriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @inquiry = Inquiry.new
    @categories = InquiryCategory.all
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.user = current_user
    @inquiry.name = current_user.name
    @inquiry.email = current_user.email
    @inquiry.category_id = params[:inquiry][:category_id]
    if @inquiry.save
      flash[:success] = 'お問い合わせの送信に成功しました。運営からの返信をお待ちください。'
      redirect_to root_path
    else
      # 失敗したら入力ページを再表示し、送信に失敗した旨のメッセージをToastで表示する
      flash.now[:error] = 'お問い合わせの送信に失敗しました。再度お試しください。'
      @categories = InquiryCategory.all
      render :new
    end
  end

  def show
    @inquiry = Inquiry.find(params[:id])
    @reply = Reply.new
  end

  # 運営用
  def create_reply
    @inquiry = Inquiry.find(params[:id])
    @reply = @inquiry.replies.build(reply_params)
    if @reply.save
      # 返信送信完了メッセージを表示する
      flash[:success] = "返信を送信しました"
      redirect_to inquiry_path(@inquiry)
    else
      # エラーメッセージを表示してフォームを再送信する
      flash.now[:danger] = "返信の送信に失敗しました"
      render :show
    end
  end

  private

  def inquiry_params
    # 入力フォームに直接入力するのは本文だけ
    # メールアドレスと名前は、usersテーブルから取り出して送信する
    params.require(:inquiry).permit(:category_id, :text)
  end

  def reply_params
    # 運営からの返信用
    params.require(:reply).permit(:text)
  end
end
