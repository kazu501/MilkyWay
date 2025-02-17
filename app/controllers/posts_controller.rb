class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user,{only:[:edit,:update,:destroy]}


  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
     @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      content: params[:content],
      title: params[:title],
      picture: params[:picture],
      user_id: @current_user.id
    )
    if @post.save
      File.binwrite("app/assets/images/#{params[:picture]}",params[:picture].read)
      flash[:notice] = "投稿が完了しました#{params[:picture]}"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] ="権限がありません"
      redirect_to("/posts/index")
    end
  end

  private
  def permit_params
    params.require(:post).permit(:title, :content, :picture)
  end


end
