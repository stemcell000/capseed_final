collection @productions
node(:id) { |production| production.id.to_s }
node(:name) { |production| production.name.to_s }
node(:resource) { |production| stepToString(production.last_step) }
node(:created_at) { |production| formatDateToGantt(production.created_at) }
node(:today_date) { |production| formatDateToGantt(production.today_date) }
node(:duration) {|production| 0}
node(:percentage) { |production| round_up(production.percentage).to_i }
node(:dependencies){ |production| 0}