class GroupsController < ApplicationController

  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group_and_check_permision , only: [:edit, :update, :destroy]


  def index
    @groups = Group.all
  # @group = Group.all 
  end

  def new
    @group = Group.new
  # @groups = Group.new
  # redirect_to groups_new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 10)
  # @group = Group.find[:id]
  # redirect_to group_show
  end

  def edit
# def edit(group)
    @group = Group.find(params[:id])
  # @group = Group.find[:id]
  # redirect_to group_edit
  end

  def create
# def create(group)
    @group = Group.new(group_params)
  # @group = Group.[params]
    @group.user = current_user
    if @group.save
  # if group.save
      redirect_to groups_path
    # redirect_to groups_index
    else
      render :new
    # render new
    end
  end


  def update
# def update(group)
    @group = Group.find(params[:id])
  # @group = Group.find[params]
    if @group.update(group_params)
  # if group.save
      redirect_to groups_path, notice: 'Update Success'
    # redirect_to groups_index
    else
      render  :edit
    # render edit
    end
  end

  def destroy
# def delete(group)
    @group = Group.find(params[:id])
    @group.destroy
    # group.destroy
    # +
    redirect_to groups_path, alert: 'Group deleted'
  end

  private

  def find_group_and_check_permision
    @group = Group.find(params[:id])
    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def group_params
# def params(group)
  # @group = Group.find[:id]
  # params = group.id, group.title, group.description, group.last_updated
    params.require(:group).permit(:title, :description)
  end
end
