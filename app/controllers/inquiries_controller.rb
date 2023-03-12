class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      # 送信に成功したら、送信完了ページにリダイレクトする
      # それか送信に成功した旨のポップアップメッセージを表示する
      redirect_to inquiries_thanks_path
    else
      # 失敗したら入力ページを再表示し、送信に失敗した旨のメッセージをToastで表示する
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
    params.require(:inquiry).permit(:content)
  end

  def reply_params
    # 運営からの返信用
    params.require(:reply).permit(:content)
  end
end
