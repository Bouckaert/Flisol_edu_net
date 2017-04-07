class HomeController < ApplicationController
  OPENREDU_URL = 'http://openredu.com'
  
  def index
    header = {'Authorization': 'Bearer ' + current_user.token}
    
    connections = HTTParty.get(
      OPENREDU_URL+"/api/users/#{current_user.login}/connections",
      headers: header,
      query: { 'status': 'accepted'}
    ).parsed_response
    
    @ranking = []
    connections.each do |connection|
      name = connection['contact']['first_name'] + ' ' + connection['contact']['last_name']
      
      link_contacts = connection['contact']['links'][4]['href']
      
      connections_friend = HTTParty.get(
        link_contacts,
        headers: header,
        query: { 'status': 'accepted'}
      ).parsed_response
      
      friend_count = connections_friend.count
      @ranking << {name: name, friend_count: friend_count}
    end
    
    @ranking.sort_by!{ |obj| -obj[:friend_count] }
  end
  
  def sign_in; end
end
