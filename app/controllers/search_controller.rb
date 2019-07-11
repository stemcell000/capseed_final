class SearchController < ApplicationController
  
def search
  if params[:q].nil?
    @clone_batches = []
  else
    @clone_batches = CloneBatch.search(params[:q]).records
  end
end
  
end
