class Round < ApplicationRecord
 belongs_to :user
  CHOICES = %w[snake water gun].freeze

  validates :player_choice, :computer_choice, :result, presence: true
  validates :player_choice, :computer_choice, inclusion: { in: CHOICES }

  # Decide result given choices - returns "Win", "Lose" or "Draw"
  def self.decide(player, computer)
    player = player.to_s
    computer = computer.to_s
    return "Draw" if player == computer

    # Rules:
    # snake drinks water => snake beats water
    # water douses gun => water beats gun
    # gun kills snake => gun beats snake
    winner = case player
             when "snake"
               computer == "water" ? "Win" : "Lose"
             when "water"
               computer == "gun" ? "Win" : "Lose"
             when "gun"
               computer == "snake" ? "Win" : "Lose"
             else
               "Draw"
             end
    winner
  end
end
