class Admin::BanItemsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @admin_comment = @item.build_admin_comment
  end

  def create
    @item = Item.find(params[:item_id])
    @admin_comment = @item.build_admin_comment params[:admin_comment]
    if @item.ban
      if @admin_comment.save
        redirect_to on_moderation_admin_items_path
      else
        render :new
      end
    else
      flash[:notice] = 'Item already banned'
      render :new
    end
  end
end
