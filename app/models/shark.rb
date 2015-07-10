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
    shark_hash = Unirest.get("#{ENV['API_BASE_URL']}/sharks/#{id}.json", headers:{ "Accept" => "#{ENV['JSON']}", "Authorization" => "#{ENV['AUTHORIZATION']}", "X-User-Email" => "#{ENV['X_USER_EMAIL']}"}).body
    Shark.new(shark_hash)
  end

  def self.all
    sharks_hashes = Unirest.get("#{ENV['API_BASE_URL']}/sharks.json", headers:{ "Accept" => "#{ENV['JSON']}", "Authorization" => "#{ENV['AUTHORIZATION']}", "X-User-Email" => "#{ENV['X_USER_EMAIL']}"}).body
    sharks = []
    sharks_hashes.each do |shark|
      sharks << Shark.new(shark)
    end
    sharks
  end

  def destroy
    Unirest.delete("#{ENV['API_BASE_URL']}/sharks/#{@id}.json", headers:{ "Accept" => "#{ENV['JSON']}", "Authorization" => "#{ENV['AUTHORIZATION']}", "X-User-Email" => "#{ENV['X_USER_EMAIL']}"})
  end

end