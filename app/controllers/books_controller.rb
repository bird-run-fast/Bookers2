  # 投稿機能用のコントローラー
class BooksController < ApplicationController
  #この文を先頭に書くとこのコントローラー内のアクションはログイン状態時のみ実行できる
  before_action :authenticate_user!

  # 以下アクション
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = User.find(@books.user_id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have creatad book successfully.'
      redirect_to books_path
    else
      flash[:notice] = "error"
      @user = current_user
      @books = Book.all
      render :index
    end
  end

   def edit
     @book = Book.find(params[:id])
     if @book.user_id == current_user.id
     else
       redirect_to books_path
     end
   end

   def update
     @book = Book.find(params[:id])
     if @book.update(book_params)
       flash[:notice] = "update is done successfully"
       redirect_to book_path(@book.id)
     else
       flash[:notice] = "error is occured"
       render :edit
     end
   end

   def destroy
     @book = Book.find(params[:id])
     @book.destroy
     flash[:notice] = "destroy is done successfully"
     redirect_to books_path
   end
  #以下ストロングパラメータ部分
#パラメータ理解が浅かったので補足でメモしとく
#普通paramsはどの部分を指すかっていうと、routesに設定されてる :id の部分から検索されたモデルの1行分の情報
  #例えば "books/:id"ってroute設定してあって "books/1"ってリンクがクリックされると
  #:id = 1 が自動で代入されて、変数 params に　各モデルの　id = 1 のカラムの情報が代入される
#ストロングパラメータはparamsの持ってる情報に制限をかけてセキュリティを向上させるための仕組み
#今回ならparamsの userテーブルの nameカラムと imageカラムだけを取得している。
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
