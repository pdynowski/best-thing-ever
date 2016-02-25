class VotesController < ApplicationController
  require "benchmark"
  def new
    session[:submitted] = false
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

    if !session[:next_pairs] #first visit
      pair = Artist.get_artist_pair
      @option1 = pair[0]
      @option2 = pair[1]
    else #other visits
      @option1 =  Artist.find(session[:next_pairs][0])
      @option2 = Artist.find(session[:next_pairs][1])
    end

    session[:id1] = @option1.id
    session[:id2] = @option2.id
    session_pair = Artist.get_artist_pair
    session[:next_pairs] = [session_pair[0].id, session_pair[1].id]
    @preload1 = Artist.find(session[:next_pairs][0])
    @preload2 = Artist.find(session[:next_pairs][1])
    @vote = Vote.new()
  end

  def create

    if((params[:winner].to_s == session[:id1].to_s && params[:loser].to_s == session[:id2].to_s) ||
      (params[:winner].to_s == session[:id2].to_s && params[:loser].to_s == session[:id1].to_s))
      if(session[:submitted] == false)
        session[:submitted] = true
        @vote = Vote.new(winner_id: params[:winner], loser_id: params[:loser], user_id: session[:user_id])
        flash[:prev_winner_id] = params[:winner]
        flash[:prev_loser_id] = params[:loser]
        if @vote.save
          redirect_to root_path
        else
          render new
        end
      else
        render "votes/vote_hack"
      end
    else
      render "votes/vote_hack"
    end
  end

end
