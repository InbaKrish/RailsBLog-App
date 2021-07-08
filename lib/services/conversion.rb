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
        def from_csv(file)
            CSV.foreach(file, headers: true) do |row|
                author = Author.create(email: row["email"],password: row["pwd"],password_confirmation: row["pwd_cnfrm"])
                puts("#{author.username} - creation failed - #{author.errors.full_messages.join(';')}") if author.errors.any?
                puts("#{author.username} - created successfully") if not author.errors
            end
        end
    end
end
