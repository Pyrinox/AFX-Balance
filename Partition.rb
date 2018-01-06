class Tools
  # converts each row in a table into an Element.
  def process_raw_data()
  end
end


class Element
  # "attributes" is a dictionary of all the properties that apply to this element,
  # as well as all the subproperty information.
  attr_accessor :id, :attributes
  def initialize(id, attributes)
    @id = id
    @attributes = attributes
  end

  # def get_id()
  #   @id_number
  # end

  # def get_attributes()
  #   @attributes
  # end

  # def get_name()
  #   @name
  # end

end



# create a new partition by initializing with a String name, list of leaders, and a list of members
class Partition
  attr_accessor :name, :leaders, :members
  

  def initialize(name, leaders = nil , members = nil)
    
    @name = name
    @leaders = leaders
    # @members = members.join(',')
    # @members = members
    # @members is a dict mapping id to Element, in order to allow for quick removal of Elements
    # as well as allow removal from a team by both Element and id
    @members = {}
    if members != nil
      for member in members
        @members[member.id] = member 
      end
    end
  end


  # IMPLEMENTATION DETAIL: should leaders be an object? 
  def add_leaders(leaders)
    #error checking: method should only accept a list
    if !leaders.is_a?(Array)
      raise ArgumentError, "add_leaders accepts a list of names."
      # return "Error: add_leaders accepts a list of names."
    end

    if @leaders == nil
      @leaders = leaders
    else
      @leaders = @leaders + leaders
    end
  end

  def remove_leaders(leaders)
    @leaders = @leaders - leaders
  end


  def add_members(members)
    
    if !members.is_a?(Array) or !members[0].is_a?(Element)
      raise ArgumentError, "add_members accepts a list of Elements."
      # return "Error: add_leaders accepts a list of names."
    end

    if @members == nil
      puts "69"
      @members = members
    else
      puts "72"
      # @members = @members + members
      for member in members
        @members[member.id] = member 
      end
    end
  end


  def remove_members(members)
    
    if !members.is_a?(Array) or (!members[0].is_a?(Element) and !members[0].is_a?(Integer))
      raise ArgumentError, "remove_members accepts a list of Elements or Integer ids."
    end
    
    # if trying to remove by Elements, delete by that Element's id.
    if members[0].is_a?(Element)
      for member in members
        @members.delete(member.id)
      end
    # if trying to remove by Integer ids, just delete by that id.
    elsif members[0].is_a?(Integer)
      for member in members
        @members.delete(member)
      end
    end
  end


# class Organization
#   attr_accessor :name, :partitions

#   def initialize(name, )


# end


end



attributes_1 = {"name": "Bob", "gender": "male", "year": "freshman", "ethnicity": "asian", "socioeconomic group": "middle class"}
attributes_2 = {"name": "Alice", "gender": "male", "year": "freshman", "ethnicity": "asian", "socioeconomic group": "middle class"}
puts "testing Element"
dancer_1 = Element.new(1, attributes_1)
dancer_2 = Element.new(2, attributes_2)
puts dancer_1.id
puts dancer_1.attributes()[:"year"]

puts ""
puts "testing Partition"
team_1 = Partition.new("AFX EQ")
puts team_1.name
team_1.add_leaders(["Katie"])
team_1.add_leaders(["Louisa"])
puts team_1.leaders
puts team_1.add_members([dancer_1])
puts team_1.add_members([dancer_2])
puts team_1.remove_members([2])
puts team_1.members









