class VotesController < ApplicationController

  def new
    @option1 = Artist.get_random_artist
    @option2 = Artist.get_random_artist
    until @option1 != @option2
      @option2 = Artist.get_random_artist
    end
    @vote = Vote.new()
  end

  def create
    @vote = Vote.new(winner_id: params[:winner], loser_id: params[:loser])
    if @vote.save
      redirect_to root_path
    else
      render new
    end
  end
end
