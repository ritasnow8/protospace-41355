class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @user = @prototype.user 
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
    redirect_to prototype_path(prototype)
    else
      render  :edit
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    if current_user != @prototype.user
      redirect_to root_path
    end
end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render :new
    end
  end
end  

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end
