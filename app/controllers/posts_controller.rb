class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_id_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new

    if !current_user.is_member_of?(@group)
      flash[:warning] = "加入后才能发表文章"
      redirect_to group_path(@group)
    end
  end

  def create
    @group =Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post.group = @group
    if @post.update(post_params)
      redirect_to account_posts_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to account_posts_path, alert: "删除成功"
  end

  private

  def find_id_and_check_permission
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    if current_user != @post.user
      redirect_to account_posts_path, alert: "You have no permission/非创建者，无权限操作"
    end

  end

  def post_params
    params.require(:post).permit(:content)
  end
end
