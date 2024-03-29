class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]


  # def new
  #   @book = Book.new
  #   @user = current_user
  # end

  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user
    @books = Book.page(params[:page])
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.page(params[:page])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
            render "edit"
    else
        redirect_to user_path(@user.id)
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path
  end


  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  

end