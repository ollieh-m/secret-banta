class SlackClient

  def self.link_account(authorization_code:, redirect_uri:)
    response = HttpRequest.new(url: 'https://www.slack.com/api/oauth.access',
                    method: :post,
                    data: { 'code' => authorization_code,
                            'client_secret' => ENV['SLACK_SECRET'],
                            'client_id' => ENV['SLACK_ID'],
                            'redirect_uri' => redirect_uri },
                    headers: { 'Content-type' => 'application/x-www-form-urlencoded' } ).perform

    if response[:status] == 200
      team = SlackTeam.find_or_initialize_by(team_id: response[:body]['team_id'])
      team.update_attributes(response[:body].extract!('access_token', 'team_name'))
      return team if team.save
    end
  end

end
