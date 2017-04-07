class HomeController < ApplicationController
  OPENREDU_URL = 'http://openredu.com'

  def index
    header = {'Authorization': 'Bearer ' + current_user.token}

    contacts = HTTParty.get(
      OPENREDU_URL+"/api/users/#{current_user.login}/contacts",
      headers: header
    )

    @ranking = []
    contacts.each do |contact|
      name = contact['first_name'].downcase.camelize + ' ' + contact['last_name'].downcase.camelize

      link_contacts = contact['links'][4]['href']

      connections_friend = HTTParty.get(
        link_contacts,
        headers: header,
        query: { 'status': 'accepted'}
      )

      friend_count = connections_friend.count
      @ranking << {name: name, friend_count: friend_count}
    end

    @ranking.sort_by!{ |obj| -obj[:friend_count] }
  end

  def sign_in; end
end
