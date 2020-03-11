class StatisticsController < ApplicationController
  
  def get_stats
      #Code pour Gon+RABL (plus lent que AMS) mais pas de coonflit avec Rails4autocomplete
      gon.rabl "app/views/statistics/get_stats.json.rabl", as: "statistics"
  end
end
