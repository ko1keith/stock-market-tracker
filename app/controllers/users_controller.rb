class UsersController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks

    @tracked_stocks.each do |tracked_stock|
      tracked_stock.last_price = Stock.update_stock(tracked_stock.ticker)
      tracked_stock.save
    end
  end
  
  def my_friends
    @friends = current_user.friend
  end

  def search 
    if params[:friend].present?
      #return collection of search results
      @friends = User.search(params[:friend])
      #in this list, if exclude current_user(logged in user) if current_user is in collection
      @friends = current_user.except_current_user(@friends)
      if @friends
          respond_to do |format|
              format.js { render partial: 'users/friend_result'}
          end
      else
          respond_to do |format|
              flash.now[:alert] = "Couldn't find user"
              format.js { render partial: 'users/friend_result'}
          end
      end
    else
      respond_to do |format|
          flash.now[:alert] = "Please enter a friend"
          format.js { render partial: 'users/friend_result'}
      end
    end
  end
end
