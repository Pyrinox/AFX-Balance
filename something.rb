dancers = Array([{"id":4,"casting_group_id":1,"name":"c","email":"c@afx.dance","phone":"222-222-2222","year":"3","gender":"Female","conflicted":false,"available":true,"expinterest":1,"experience":"No","availability":{"1":"1"},"devinterest":false},{"id":3,"casting_group_id":1,"name":"b","email":"b@afx.dance","phone":"111-222-2222","year":"2","gender":"Male","conflicted":false,"available":true,"expinterest":1,"experience":"YesNoAFX","availability":{"1":"1"},"devinterest":false},{"id":2,"casting_group_id":1,"name":"a","email":"a@afx.dance","phone":"111-111-1111","year":"2","gender":"Male","conflicted":false,"available":true,"expinterest":1,"experience":"No","availability":{"1":"1"},"devinterest":false},{"id":1,"casting_group_id":1,"name":"Victoria","email":"vpark@berkeley.edu","phone":"123-456-7890","year":"1","gender":"Female","conflicted":false,"available":true,"expinterest":1,"experience":"No","availability":{"1":"0"},"devinterest":false}])
teams = Array([{"count": 80, "gender_ratio": 0.5, "id":3,"project":false,"name":"s3","locked":false,"maximum_picks":1,"timestring":""},{ "count": 100,"gender_ratio": 0.5,"id":2,"project":true,"name":"christoria","locked":false,"maximum_picks":10,"timestring":"whenever"},{"count": 90,"gender_ratio": 0.6,"id":1,"project":true,"name":"AFX tech","locked":false,"maximum_picks":10,"timestring":""}])
dancer = {:gender => 1, :name => "Bob"}
def algorithm(teams, dancer)
    # calculate / find each team's ratio
    # print out 
    teamDict = {}
    teams.each do |team|
        # puts team[:count]
        numM = team[:gender_ratio] * team[:count]
        numMnew = (numM + dancer[:gender]) / (team[:count] + 1)
        teamDict[numMnew] = team
        # puts (team[:gender_ratio] * team[:count])
        # team.add(dancer)
    end
    puts teamDict
    return teamDict.max #teamDict.max_by {|h| h[]
    # arr.max_by {|hash| hash['x']}['y']
end

algorithm(teams, 1)