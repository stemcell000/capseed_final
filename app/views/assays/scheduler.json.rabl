collection @assays
node(:id) { |assay| assay.id.to_s }
node(:name) { |assay| assay.id.to_s }
node(:resource) { |assay| stepToString(assay.last_step) }
node(:created_at) { |assay| formatDateToGantt(assay.created_at) }
node(:today_date) { |assay| assay.today_date.nil? ? Date.today : assay.today_date}
node(:duration) {|assay| 0}
node(:percentage) { |assay| round_up(assay.percentage).to_i }
node(:dependencies){ |assay| 0}