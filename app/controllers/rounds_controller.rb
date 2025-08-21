class RoundsController < ApplicationController
  before_action :authenticate_user!
  def new
    @round = Round.new
  end

  def create
    player_choice = params[:choice].to_s.downcase
    unless Round::CHOICES.include?(player_choice)
      redirect_to root_path, alert: "Invalid choice." and return
    end

    computer_choice = Round::CHOICES.sample
    result = Round.decide(player_choice, computer_choice)

    @round = current_user.rounds.build(
      player_choice: player_choice,
      computer_choice: computer_choice,
      result: result
      )

    if @round.save
      redirect_to @round
    else
      redirect_to root_path, alert: "Could not save round. Try again."
    end
  end

  def index
    @recent_rounds = current_user.rounds.order(created_at: :desc).limit(20)
    @scores = current_user.rounds.group(:result).count
    @choice_counts = current_user.rounds.group(:player_choice).count
  end


  def show
    @round = Round.find(params[:id])
  end

  def index
    # Show recent rounds and simple leaderboard counts
    @recent_rounds = Round.order(created_at: :desc).limit(20)
    @scores = Round.group(:result).count
    # also compute top choices statistics (optional)
    @choice_counts = Round.group(:player_choice).count
  end
end
