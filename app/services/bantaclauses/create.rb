class Bantaclauses::Create

  attr_reader :params, :slack_team

  def initialize(params)
    @params = params
    @slack_team = SlackTeam.find_by(team_id: params[:team_id])
  end

  def perform
    return check_token unless check_token[:success]
    return get_members unless get_members[:success]
    return allocate_members unless allocate_members[:success]
    send_messages_to_users
  end

  def check_token
    params[:token] == ENV['SLACK_VERIFICATION'] ? {success: true} : {success: false, content: 'Invalid slack verification token'}
  end

  def get_members
    @get_members ||= ::SlackClient.get_members(slack_team)
  end

  def allocate_members
    @allocate_members ||= ::Allocator.perform(get_members[:content])
  end

  def send_messages_to_users
    @send_messages_to_users ||= ::SlackClient.send_messages(slack_team, allocate_members[:content])
  end

end
