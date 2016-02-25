class VotesController < ApplicationController
  require "benchmark"
  def new

    # if session[:click] == nil
    #   session[:click] = 0
    #   # @click = 0
    # else
    #   # @click = 0
    #   session[:click] += 1
    #     if session[:click] > 1
    #       # @click = 0
    #       session[:click] = nil
    #     end
    # end


    if flash[:prev_winner_id]
      @prev_winner = Artist.find(flash[:prev_winner_id])
      @prev_loser = Artist.find(flash[:prev_loser_id])

      scores = Artist.score
      rankings = Artist.ranking(scores)

      @prev_winner_score = scores[@prev_winner.id]
      @prev_loser_score = scores[@prev_loser.id]
      @prev_winner_ranking = rankings[@prev_winner.id]
      @prev_loser_ranking = rankings[@prev_loser.id]
    end

    @option1 = Artist.get_random_artist
    @option2 = Artist.get_random_artist

    until @option1 != @option2
      @option2 = Artist.get_random_artist
    end
    @vote = Vote.new()

  end

  def create
    @vote = Vote.new(winner_id: params[:winner], loser_id: params[:loser], user_id: session[:user_id])
    flash[:prev_winner_id] = params[:winner]
    flash[:prev_loser_id] = params[:loser]
    if @vote.save
      redirect_to root_path
    else
      render new
    end
  end

end
