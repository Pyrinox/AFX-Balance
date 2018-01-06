class Tools
  attr_accessor :balance_factors

  def initialize()
    # @balance_factors = nil
  end


  # converts each row in a table into an Element.
  # need to find out what format the import data will be in.
  def process_raw_data()

    #returns a comprehensive list of all Elements
  end


  def psuedo_element_generator(num_to_generate, balance_factors)
    # if @balance_factors == nil
    #   raise RuntimeError, "Cannot generate Elements because Tool's @balance_factors var not set."
    # end

    list_of_elements = []
    bf_keys = balance_factors.keys
    bf_values = balance_factors.values.flatten
    for id in 1..num_to_generate
      attributes = {}
      for key in bf_keys
        val = @balance_factors[key]
        rand_int = rand(val.length)
        sel = val[rand_int]
        attributes[key] = sel
      end
      element = Element.new(id, attributes)
      list_of_elements.push(element)
    end
    list_of_elements
  end

  #partition_names is a list of String names
  def psuedo_partition_generator(partition_names)
    list_of_partitions = []
    for partition_name in partition_names
      partition = Partition.new()
      list_of_partitions.push()
    end

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
  
  # "members" must be a list of ELEMENTS
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


  #Ask about: rudundant add_members code in Partition and Organization
  def add_members(members)
    
    if !members.is_a?(Array) or (!members[0].is_a?(Element) and !members[0].is_a?(Integer))
      raise ArgumentError, "add_members accepts a list of Elements or Integer ids."
      # return "Error: add_leaders accepts a list of names."
    end

    if members != nil
      for member in members
        @members[member.id] = member 
      end
    end

    for member in members
      @members[member.id] = member 
    end

    # if @members == nil
    #   puts "69"
    #   @members = members
    # else
    #   puts "72"
    #   # @members = @members + members
    #   for member in members
    #     @members[member.id] = member 
    #   end
    # end
  end

  #Ask about: rudundant remove_members code in Partition and Organization
  def remove_members(members)
    
    if !members.is_a?(Array) or (!members[0].is_a?(Element) and !members[0].is_a?(Integer))
      raise ArgumentError, "remove_members accepts a list of Elements or Integer ids."
    end
    
    # if trying to remove by Elements, delete by that Element's id.
    if members[0].is_a?(Element)
      # add a nil check
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
end


class Organization
  attr_accessor :name, :partitions, :members, :characteristic_frequencies, :characteristic_ratios

  #members is a list of Elements
  #balance_factors is a dictionary. Key = String property. Value = list of String property characteristics.
  #partitions is a list of Partitions
  def initialize(name, members, partitions, balance_factors)
    @members = {}
    if members != nil
      for member in members
        @members[member.id] = member 
      end
    end
    
    @characteristic_frequencies = {}
    @balance_factors = balance_factors
    @bf_keys = balance_factors.keys
    @bf_values = balance_factors.values.flatten

    #initialize all relevant org factors to 0
    for factor in @bf_values
      @characteristic_frequencies[factor] = 0
    end

    #increment correct "bin" to keep track of freq of certain characteristic
    for member in members
      for key in @bf_keys
        @characteristic_frequencies[member.attributes[key]] += 1
        # puts member.attributes[key]
      end
    end

    # consistency check
    total = check_consistency(@characteristic_frequencies)
    #research ruby try/catch
    if !total
      raise RuntimeError, "Inconsistent data. The frequency totals between different properties should be the same."
    end

    @characteristic_ratios = {}
    for key in @characteristic_frequencies.keys
      @characteristic_ratios[key] = @characteristic_frequencies[key].to_f/total.to_f
    end


    puts @characteristic_ratios




    # puts @characteristic_frequencies

    # for factor in balance_factors
    #   for member in members
    #     if member.attributes[]

    #     @characteristic_frequencies[factor] += 1


    # @property_weights = {}
    # @property_characteristics = {}
    # @characteristic_magnitudes = {}
    # @team_initialization = []
    # @partitions = {}
  end

  # char_mag_dict is a dictionary that counts frequency of a specific char in the org.
  # checks all the numbers add up. if they do, return the total they add up to. If not, return false.
  def check_consistency(char_mag_dict)
    consistency_list = []
    
    for key in @bf_keys
      sum = 0
      for val in @balance_factors[key]
        sum += @characteristic_frequencies[val]
      end
      consistency_list.push(sum)
    end
    
    if consistency_list.uniq.length == 1
      return consistency_list[0]
    else
      #mismatched data. the total of the freq's between different characteristics do not match up
      return false
    end
    
  end
  
  #Ask about: rudundant add_members code in Partition and Organization
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

  #Ask about: rudundant remove_members code in Partition and Organization
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









  def attributes
    return @attributes
  end
  
  # e.g. 
  def add_property(property, weight, characteristics)
    # check the total weight = 1
    @property_weights[property] = weight
    @property_characteristics[property] = characteristics
  end
  

  def add_magnitudes(property, magnitudes)
    @characteristic_magnitudes[property] = magnitudes
  end
  
  # "partitions" is a list of partitions
  # partitions = [(afx_team_name_string, directors_list, members)]
  def initializePartitions(partition_list)
    # check if "partition_list" is a list of Partitions 
    if partition_list[0].is_a?(Partition)
      for partiton in partition_list
        p_name = partition.get_name()
        @partitions[p_name] = partition
      end
    # otherwise, "partition_list" is a list of String names.
    elsif partition_list[0].is_a?(String)
      # create Partitions using String names.
      for partiton in partition_list
        p_obj = Partition.new(partition)
        @partitions[partition] = p_obj
      end
    elsif partition_list[0].is_a?(String)
    end

    for partiton in partitions
      if partition.length == 1
      end
      if partition.length == 2
      end
      partiton_obj = Partition.new(partition)
      @partitions.push(partiton_obj)
    end
  end  
end


balance_factors = {"gender": ["male", "female", "other"], "year": ["freshman", "sophomore", "junior", "senior"]}

puts "***testing Tools***"
tool = Tools.new()
tool.balance_factors = balance_factors
members = tool.psuedo_element_generator(10, balance_factors)
partition_names = ["AFX ANTHM", "AFX EQ", "AFX Bangzi", "AFX Bae", "AFX SoloQ", "AFX Apocalyse", "AFX 404"]



attributes_1 = {"name": "Bob", "gender": "male", "year": "freshman", "ethnicity": "asian", "socioeconomic group": "middle class"}
attributes_2 = {"name": "Alice", "gender": "female", "year": "junior", "ethnicity": "asian", "socioeconomic group": "middle class"}
puts "***testing Element***"
dancer_1 = Element.new(1, attributes_1)
dancer_2 = Element.new(2, attributes_2)
# puts dancer_1.id
# puts dancer_1.attributes()[:"year"]

# puts ""
# puts "testing Partition"
# team_1 = Partition.new("AFX EQ")
# puts team_1.name
# team_1.add_leaders(["Katie"])
# team_1.add_leaders(["Louisa"])
# puts team_1.leaders
# puts team_1.add_members([dancer_1])
# puts team_1.add_members([dancer_2])
# puts team_1.remove_members([2])
# puts team_1.members

# # ------------------------------------

# naive_teams = [afx_training1, afx_training2, afx_training3]
# #take into account number of directors later
# total_number_people = 680
# org_gender_male = 300
# org_gender_female = 362
# org_gender_other = 18
# org_year_freshman = 300
# org_year_sophomore = 177
# org_year_junior = 136
# org_year_senior = 67

# base = Organization.new("AFX")
# # base.add_property adds a property with an importance weight and the following characteristics.
# base.add_property("gender", 0.25, ["male", "female", "other"])
# base.add_property("year", 0.25, ["freshman", "sophomore", "junior", "senior"])
# base.add_property("ethnicity", 0.25, ["asian", "latino", "american", "african american"] )
# base.add_property("socioeconomic group", 0.25, ["upper class", "middle class", "lower class"])


# # base.add_magnitudes gives each sub-property a magnitude.
# # base.add_magnitudes should throw error if total number of people across sub-properties are not the same
# # i.e. the total number of people is inconsisent.
# base.add_magnitudes("gender", {"male": org_gender_male, "female": org_gender_female, "other": org_gender_other})
# base.add_magnitudes("year", {"freshman": org_year_freshman, "sophomore": org_year_sophomore, "junior": org_year_junior, "senior": org_year_senior})
# base.add_magnitudes("ethnicity", {"asian": 170, "latino": 170, "american": 170, "african american": 170})
# base.add_magnitudes("socioeconomic group", {"upper class": 170, "middle class": 170, "lower class": 340})
# #base.add_magnitudes("total", total_number_people)

puts "***testing Organization***"
# members = [dancer_1, dancer_2]
# balance_factors = {"gender": ["male", "female", "other"], "year": ["freshman", "sophomore", "junior", "senior"]}
org = Organization.new("AFX", members, partitions, balance_factors)
puts org.characteristic_frequencies







