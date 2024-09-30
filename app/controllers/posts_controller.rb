class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html  # For regular HTML request
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(posts_params)
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(posts_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.turbo_stream
        format.html { redirect_to @post, notice: 'Post was successfully destroyed.' }
      else
        format.html { redirect_to @post, status: :unprocessable_entity }
      end
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
