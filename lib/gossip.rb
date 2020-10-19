require 'csv'
# require 'pry'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.update(id, new_author, new_content)
    all_gossips = self.all
    all_gossips[id].author = new_author
    all_gossips[id].content = new_content
    CSV.open("./db/gossip.csv", "w") do |csv|
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips 
  end

  def self.find(id)
    return CSV.read("./db/gossip.csv")[id]
  end
end


# binding.pry