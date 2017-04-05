class Bantaclauses::Create

  attr_reader :params, :slack_team

  def initialize(params)
    @params = params
    @slack_team = SlackTeam.find_by(team_id: params[:team_id])
  end

  def perform
    binding.pry
    return check_token unless check_token[:success]
    return get_members unless get_members[:success]
    # assign each of them a recipient
    # send a PRIVATE message to each of them with the name of their recipient

  end

  def check_token
    params[:token] == ENV['SLACK_VERIFICATION'] ? {success: true} : {success: false, content: 'Invalid slack verification token'}
  end

  def get_members
    @get_members ||= ::SlackClient.get_members(slack_team)
  end

end
