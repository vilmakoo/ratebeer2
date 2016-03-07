class RatingsController < ApplicationController
  def index
    Rails.cache.write("beer top 3", Beer.top(3)) if cache_does_not_contain_data_or_it_is_too_old
    @top_beers = Rails.cache.read "beer top 3"
    @top_breweries = Brewery.top(3)
    @top_styles = Style.top(3)
    @most_active_users = User.most_active(3)
    @recent_ratings = Rating.recent
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end