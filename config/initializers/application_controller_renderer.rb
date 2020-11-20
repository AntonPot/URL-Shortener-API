ActionController::Renderers.add :csv do |obj, options|
  filename = options[:filename] || 'data'
  send_data GenerateCsv.run(obj),
            type: Mime[:csv],
            disposition: "attachment; filename=#{filename}.csv"
end
