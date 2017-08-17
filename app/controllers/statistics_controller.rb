class StatisticsController < ApplicationController
  
  def get_stats
    #Code pour Active Model Serializer -> pour le fichier stat_serializer.rb
   #  @stats = Stat.all
    #  respond_to do |format|
     #   format.html
      #  format.json {render :json => @stats, :root => false}
      #end
      #Code pour Gon+RABL (plus lent que AMS) mais pas de coonflit avec Rails4autocomplete
      gon.rabl "app/views/statistics/get_stats.json.rabl", as: "statistics"
  end
end
