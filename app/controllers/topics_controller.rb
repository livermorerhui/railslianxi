class TopicsController < ApplicationController
  def index
    @topics = Topic.all.sort_by{|topic| topic.votes.count}.reverse
    #按降序排列得票数
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topics_path
    else
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      redirect_to topics_path
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path
  end

  def upvote #喜欢话题，给一票
    @topic = Topic.find(params[:id])
    @topic.votes.create
    redirect_to topics_path
  end

  def downvote  #讨厌话题，扣一票
    @topic = Topic.find(params[:id])
    if @topic.votes.count != 0
      @topic.votes.first.destroy
    end
    redirect_to topics_path
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :description)
  end

end
