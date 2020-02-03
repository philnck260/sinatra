require "csv"

class Gossip
  attr_accessor :author, :content, :id

  def initialize(auteur, content, id = 0)
    @id = id
    @author = auteur
    @content = content
  end

  def save
    CSV.open("db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    a = 0
    CSV.read("db/gossip.csv").each do |csv_line|
      a += 1
      all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2].to_i + a)
    end
    return all_gossips
  end

  def self.find_content(id)
    Gossip.all.each do |csv|
      if csv.id == id
        return csv.content
      end
    end
  end

  def self.find_author(id)
    Gossip.all.each do |csv|
      if csv.id == id
        return csv.author
      end
    end
  end
end
