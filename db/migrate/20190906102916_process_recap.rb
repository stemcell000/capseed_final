class ProcessRecap < ActiveRecord::Migration
  def change
        CloneBatch.all.each do |object|
      
      number= object.number.nil? ? '-' : object.number 
      date_as_plasmid = object.date_as_plasmid.nil? ? '-' : object.date_as_plasmid.strftime('%b %e, %Y')
      glyc_stock_box_as_plasmid = object.glyc_stock_box_as_plasmid.nil? ? 'No data' : object.glyc_stock_box_as_plasmid
      origin = object.origin.nil? ? '-' : object.origin.name
      type = object.type.nil? ? '-' : object.type.name
      nb_of_batches = object.plasmid_batches.empty? ? '-' : object.plasmid_batches.length
      clone = object.clone.nil? ? '-' : object.clone.name
      target = object.target.nil? ? '-' : object.target.name
      strand  = object.strand.nil? ? '-' : object.strand.name
      promoters = object.promoters.nil? ? '-' : object.promoters.uniq.map {|promoter| promoter.name}.to_sentence
      genes = object.genes.nil? ? '-' : object.genes.uniq.map {|gene| gene.name}.to_sentence
      comment = object.comment_as_plasmid.nil? ? '' : ' '+object.comment_as_plasmid
      
       block = "<i class='glyphicon glyphicon-inbox'></i> <strong>Number: </strong> #{ number } <br />
       <i class='glyphicon glyphicon-calendar'></i> <strong> Date: </strong> #{ date_as_plasmid} <br />
       <i class='glyphicon glyphicon-inbox'></i> <strong>Glycerol stock box: </strong> #{glyc_stock_box_as_plasmid } <br />
       <i class='glyphicon glyphicon-home'></i> <strong>Origin: </strong> #{ origin } <br />
       <i class='glyphicon glyphicon-inbox'></i> <strong>Type: </strong> #{ type }<br />
       <i class='glyphicon glyphicon-th'></i> <strong>Number of batches: </strong> #{ nb_of_batches }<br />
       <strong>Clone: </strong> #{clone } <br />
       <strong>Target: </strong> #{ target } <br />
       <strong>Strand: </strong> #{ strand } <br />
       <strong>Promoter: </strong> #{ promoters } <br />
       <strong>Gene: </strong> #{ genes }<br />
       <strong>Comments: </strong> #{ comment } <br />"
      
      
      object.update_columns(:recap => block)
  end
end
