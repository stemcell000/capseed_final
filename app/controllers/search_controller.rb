class SearchController < ApplicationController
  
def search
  if params[:q].nil?
    @clone_batches = []
  else
    @clone_batches = CloneBatch.search(params[:q]).records
  end
end

def search_virus
  if params[:q].nil?
    @virus_productions = []
  else
    @virus_productions = VirusProduction.search(params[:q]).records
  end
end
  
end
