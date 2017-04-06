class Allocator

  def self.perform(array_of_users)
    array_of_recipients = []

    array_of_users.each do |user|
      recipient = (array_of_users - [user] - array_of_recipients).sample

      user['recipient'] = recipient['name']
      array_of_recipients << recipient
    end

    p array_of_users

    # shuffle array of users, assign each the next along as their recipient

    {success: true, content: array_of_users}
  end

end
