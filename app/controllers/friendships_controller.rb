class FriendshipsController < ApplicationController
  def index
    @friendship_requests = Friendship.where('friend_two_id = ? AND confirmed = ?', current_user.id, false)
    @friendships_notaccepted = Friendship.where('friend_two_id = ? OR friend_one_id = ?', current_user.id, current_user.id)
    if @friendships_notaccepted.length.positive?
      @friendships = @friendships_notaccepted.select { |fs| fs.confirmed == true }
      @friendships_pending = @friendships_notaccepted.select { |fs| fs.confirmed == false }
    end
    if @friendships && @friendships.length.positive?
      @two_is_friends = @friendships.select { |f| f.friend_one_id == current_user.id } # friend_two_id is friend
      @one_is_friends = @friendships.select { |f| f.friend_two_id == current_user.id } # friend_one_id is friend
    end
    @friendship = Friendship.new
  end

  def show
  end

  def create
    @friendship = Friendship.new
    if params[:format]
      @friendship.friend_one_id = current_user.id
      @friendship.friend_two_id = User.find(params[:format]).id
      @friendship.save
    elsif params[:user_id] != current_user.id
      friend_ids = params[:friendship][:friend_two_id].select { |id| id != "" }
      friend_ids.each do |id|
        @friendship = Friendship.new
        @friendship.friend_one_id = current_user.id
        @friendship.friend_two_id = User.find(id).id
        @friendship.save
      end
    else
      @friendship.friend_one_id = current_user.id
      @friendship.friend_two_id = User.find(params[:user_id]).id
      @friendship.save!
    end
    redirect_to "/"
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to "/"
  end

  def accept
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true
    @friendship.save
    redirect_to "/"
  end
end
