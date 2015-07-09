class Shark
attr_accessor :common_name, :latin_name, :habitat_range, :attacks_on_humans, :id
  def initialize(hash)
    @id = hash["id"]
    @common_name = hash["common_name"]
    @latin_name = hash["latin_name"]
    @habitat_range = hash["habitat_range"]
    @attacks_on_humans = hash["attacks_on_humans"]
  end

  def self.find(id)
    shark_hash = Unirest.get("http://localhost:3000/v1/sharks/#{id}.json").body
    Shark.new(shark_hash)
  end

  def self.all
    sharks_hashes = Unirest.get("http://localhost:3000/v1/sharks.json").body
    sharks = []
    sharks_hashes.each do |shark|
      sharks << Shark.new(shark)
    end
    sharks
  end

  def destroy
    Unirest.delete("http://localhost:3000/v1/sharks/#{@id}.json", headers:{ "Accept" => "application/json" })
  end

end