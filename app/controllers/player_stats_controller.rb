class PlayerStatsController < ApplicationController

  def new
    @game = Game.find(params[:game_id])
    @skip_navbar = true
    @skip_footer = true
    # @participation = current_user.participations.find_by(game_id: @game.id)
    # @player_stat = @participation.player_stats
    @playerstat = PlayerStat.new
  end

  def create
    @game = Game.find(player_stat_params[:game_id])
    clone = player_stat_params.clone
    clone.delete(:game_id)
    @participation = Participation.find(clone[:participation_id])
    if @participation.player_stat.nil?
      @player_stat = PlayerStat.new(clone)
      tirs_tentes_points
      if @player_stat.save
        redirect_to play_game_path(@game)
      end
    else
      tirs_tentes_points
      @participation.player_stat.save
      redirect_to play_game_path(@game)
    end
  end

  private

  def player_stat_params
    params.require(:player_stat).permit(:point, :fault, :ft_made, :fg_made, :threep_made, :ft_attempt, :fg_attempt, :threep_attempt, :block, :turnover, :steal, :assist, :off_rebound, :def_rebound, :minute, :participation_id, :game_id)
  end

  def tirs_tentes_points
    if params[:player_stat][:ft_made].present?
      @participation.player_stat.ft_made += 1
      @participation.player_stat.ft_attempt += 1
      @participation.player_stat.point += 1
    elsif params[:player_stat][:fg_made].present?
      @participation.player_stat.fg_made += 1
      @participation.player_stat.fg_attempt += 1
      @participation.player_stat.point += 2
    elsif params[:player_stat][:threep_made].present?
      @participation.player_stat.threep_made += 1
      @participation.player_stat.threep_attempt += 1
      @participation.player_stat.point += 3
    elsif params[:player_stat][:ft_attempt].present?
      @participation.player_stat.ft_attempt += 1
    elsif params[:player_stat][:fg_attempt].present?
      @participation.player_stat.fg_attempt += 1
    elsif params[:player_stat][:threep_attempt].present?
      @participation.player_stat.threep_attempt += 1
    elsif params[:player_stat][:block].present?
      @participation.player_stat.block += 1
    elsif params[:player_stat][:assist].present?
      @participation.player_stat.assist += 1
    elsif params[:player_stat][:turnover].present?
      @participation.player_stat.turnover += 1
    elsif params[:player_stat][:steal].present?
      @participation.player_stat.steal += 1
    elsif params[:player_stat][:off_rebound].present?
      @participation.player_stat.off_rebound += 1
    elsif params[:player_stat][:def_rebound].present?
      @participation.player_stat.def_rebound += 1
    elsif params[:player_stat][:fault].present?
      @participation.player_stat.fault += 1
    end
  end
end


# POUR LES MINUTES DE TEMPS DE JEU :
# chaque QT commence a 10:00 minutes
# lors d'un changement on demande quel temps il reste sur le tableau d'affichage :
# 9:30 9:00 8:30 8:00 7:30 7:00 ...
# on soustrait ce temps de 10:00
# ca nous donne le nombre de minutes jouées pour un joueur
# stocker ça dans une variable "minutes_played"
#    elsif params[:player_stat][:minute].present?
#      @participation.player_stat.minute += {minutes_played}
