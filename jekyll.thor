require 'stringex'

class Jekyll < Thor
  desc :new, 'create a new post'

  method_option :editor, :default => 'editor'

  def new(*title)
    now = Time.now
    title = title.join(' ').strip

    if title.empty?
      abort('title is missing or empty')
    end

    date = now.strftime('%Y-%m-%d')
    filename = "_posts/#{date}-#{title.to_url}.markdown"

    if File.exist?(filename)
      abort("#{filename} already exists")
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts '---'
      post.puts "layout: post"
      post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
      post.puts "date: #{now.strftime("%Y-%m-%d %H:%M:%S %z")}"
      post.puts "categories:"
      post.puts '---'
    end

    system(options[:editor], filename)
  end
end
