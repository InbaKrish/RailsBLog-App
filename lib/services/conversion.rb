module Services
    class Conversion
        def to_csv
            attributes = %w{id title description}

            CSV.generate(headers: true) do |csv|
                csv << attributes
                Article.all.each do |article|
                    csv << article.attributes.values_at(*attributes)
                end
            end
        end
    end
end
