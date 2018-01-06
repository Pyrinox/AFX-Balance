# We want to separate items in a set into partitions.
#
# We want to balance out the attributes of the items, such that the distribution
# of attributes in each partition mirrors that of the entire set.
#
# To do this, we calculate a "balance score" for each partition, and average them
# get a balance score for all the partitions.
#
# Given an unassigned item and a list of partitions, we try putting them 
# This finds the optimal partition to put that item in to maintai n balance.


class Partition
  def initialize(name, directors, *dancers)
    @name = name
    @directors = directors
    @dancers = dancers.join(',')
  end
  
  # def initialize(team)
  #   @team_name = team["name"]
  #   @dancers = team["dancers"]
  #   @directors = team["directors"]
  # end
  
end

# This is already in auditions-app/dancer.rb
# class Dancer
#   def initialize(name, gender, year)
#     @name = name
#     @gender = gender
#     @year = year
#   end

# end


# def balanceCalculation(listOfAttributes1, listOfAttributes2)
# #   for each
# #   map()
#     euclidean_distance(listOfAttributes1, listOfAttributes2)
# end


# def euclidean_distance(p1,p2)
#   sum_of_squares = 0
#   p1.each_with_index do |p1_coord,index| 
#     sum_of_squares += (p1_coord - p2[index]) ** 2 
#   end
#   Math.sqrt( sum_of_squares )
# end


#calculate balance score for a team/partition
def partitionBalanceScore(partition)
  allPartitionsRatio
  partitionRatio
  attributes
  perAttributeBalanceScores = attributes.map do | attribute |
    attribute[:method]
    return attribute[:weight] * 
  end
  perAttributeBalanceScores
end

# AFXInitializer is the general base class that provides the info necessary to initialize all other classes
class Organization
  def initialize()
    @property_weights = {}
    @property_characteristics = {}
    @magnitudes = {}
    @team_initialization = []
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
    @magnitudes[property] = magnitudes
  end
  
 
  
  def calculate_ratios()
    
    
end

##################### users point of view

# Let us assume we are given the following:
# the total number of auditionees : num_auditionees
# the number of females and males : gender_ratio
# the number of froshies, sophos, juniors, seniores : []
# we are given all the teams 

# Goal: user has teams, and 1 switching dancer who has listed two teams he/she would switch onto
# recommend better team to switch on to between the two provided by dancer

# training teams. don't project teams b/c those swiches should be manual.

#every team is a Team class
naive_teams = [afx_training1, afx_training2, afx_training3]
#take into account number of directors later
total_number_people = 680
org_gender_male = 300
org_gender_female = 362
org_gender_other = 18
org_year_freshman = 300
org_year_sophomore = 177
org_year_junior = 136
org_year_senior = 67

base = Organization.new()
base.add_property("gender", 0.5, ["male", "female", "other"])
base.add_property("year", 0.5, ["freshman", "sophomore", "junior", "senior"])

base.add_magnitudes("gender", {"male": org_gender_male, "female": org_gender_female, "other": org_gender_other})
base.add_magnitudes("year", {"freshman": org_year_freshman, "sophomore": org_year_sophomore, "junior": org_year_junior, "senior": org_year_senior})
base.add_magnitudes("total", total_number_people)

# to instantiate teams from the data given


partitions = []
for team in naive_teams
  init_team = Partition.new()
  partitions.add(init_team)
  base.initializePartitions(team)
end


def make_ratio(attribute,key, magnitude) 
  # get attribute and divide by total magnitude
  return (magnitude[attribute][key])/magnitude
end

class

ratio["gender"]["male"]

characteristics_magnitude

org = Partition(num numb nujb jujd fsjfjfs fd sd s ds fsd)
org.ratio
team1 = Partition(fjn fe  efs sfe sfe s)




##################### users point of view

# attributes = [
#     {
#         property: &:gender,
#         weight: 0.5,
#     },
#     {
#         property: &:year,
#         weight: 0.5,
#     }
# ]




totalRatio = {
  gender:
    male: 0.5
    female: 0.5
  year:
    1: 0.25
    2: 0.25
    3: 0.25
    4: 0.25
}

partitionRatio = [
  {
    gender:
      male: 0.5
      female: 0.5
    year:
      1: 0.25
      2: 0.25
      3: 0.25
      4: 0.25
  },
  {
    gender:
      male: 0.5
      female: 0.5
    year
      1: 0.25
      2: 0.25
      3: 0.25
      4: 0.25
  }
]

#Org = total list of dancers, balance score
#Team = team_size, ratio of gender, ratio of years, ratio of other attributes
#Dancer = gender, year, etc.

# Example:
# takes in: 
#   attribute: {method: &:gender, weight: 0.5}
#   partition: [Dancer<gender: 'male'>, Dancer<gender: 'female'>]
# returns: {'male': 0.5, 'female': 0.5}
def get_attribute_ratios(attribute, partition)
  result = {}
  for item in partition
    value = attribute[:method](item)
    result[value] += (1 / partition.length)
  end
  return result
end

def get_team_ratio(attribute_ratio)
  
end

class Balancer
  # partitions is a list 
  # pass in AttributesBuilder Class
  def initialize(partitions, attributesBuilder, totalRatio)
    @partitions = partitions
    @attributes = attributesBuilder
    @totalRatio = totalRatio
  end
  
  # 
  def balance_score()
    @partitions.map { |partition| balance_score_per_partition(partition) }.sum()
  end
  
  # 
  def balance_score_per_partition(partitions)
    @attributes.map { |attribute| balance_score_per_attribute(partitions, attribute) }.sum() ** 2
  end
  
  #how balanced is this partition in terms of this attribute
  def balance_score_per_attribute(partitions, attribute)
    values = @totalRatio[attribute].keys  # example: values == ['male', 'female']
    attribute.weight * sqrt(values.map { |value| balance_score_per_value(partitions, attribute, value) }.sum())
  end
  
  # partition is one team, attribute
  # value is the organization's overall ideal ratio
  def balance_score_per_value(partition, attribute, sub_attribute)
    # squared difference of team and org
    (partitionRatio[attribute][sub_attribute] - totalRatio[attribute][sub_attribute]) ** 2
  end
  
end




# # attributes[0][:method](item) => item.gender
# # attributes is a dictionary of lists {gender:[male, female], year:[freshman, sophomore, junior, senior] }
# def totalBalanceScore(partitions, attributes)
#   # average of all the partition balance scores
#   # returns sum of squares of each partition
#   balanceScore = 0
#   for partition in partitions
#     for attribute in attributes
#       values = totalRatio[attribute].keys  # example: values == ['male', 'female']
#       value_distance = 0
#       for value in values
#         value_distance += (partitionRatio[attribute][value] - totalRatio[attribute][value]) ** 2
#       end
#       balanceScore +=  (attribute.weight * sqrt(value_distance))**2
#     end
#   end
#   return balanceScore
# end



# given a item that needs to switch, what team/partition to switch to?
def optimalPartitionChoice(item, partitions)
    
    totaBalanceScores = {nameOfPartition: balanceScore}
    for each partiton in partitions
        add item to partition temporarily
        totaBalanceScores[partition] = totalBalanceScore(partitions)
        remove item from partition
    
    find min of totaBalanceScores and get partition
    return partition
    
end


def optimalPartitionChoice2(item, partitions)
    partitionToScore = {}
    partitions.each do |partition|
        # temporarily add dancer to partition
        partitionToScore[partition] = partitionBalanceScore(partition.insert(item))
    end
    # Goal: add dancer to partition that minimizes totalBalanceScore
    return smallest_hash_key(partitionToScore) # returns best partition
end



def smallest_hash_key(hash)
    hash.min_by{|k,v| v}
end
    