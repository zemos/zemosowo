class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "New quotation created!"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  def showAll
    @microposts = Micropost.text_search(params[:query]).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @microposts }
    end
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
 
end