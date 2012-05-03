class Message < ActiveRecord::Base

  def from_name
    if from_user == -1
      return 'Admin'
    else
      return User.find_by_id(from_user).email
    end
  end
  
  def to_name
    if to_user == -1
      return 'Admin'
    else
      return User.find_by_id(to_user).email
    end
  end

  def viewable_by(user_id)
    if user_id == 'Admin' or user_id == 'admin' or User.find_by_id(user_id).admin
      return true
    end
    if to_user == user_id or from_user == user_id
      return true
    end
  end

  def is_collaborator(user_id)
    if user_id == 'Admin' or user_id == 'admin' or User.find_by_id(user_id).admin
      user_id = -1
    end
    return (user_id == to_user or user_id == from_user)
  end

  def other_user(user_id)
    if not is_collaborator(user_id)
      return nil
    end
    if User.find_by_id(user_id).admin
      user_id = -1
    end
    if user_id == to_user
      return from_user
    else
      return to_user
    end
  end
    

  def self.messages_to(user_id)
    if user_id == 'Admin' or user_id == 'admin' or User.find_by_id(user_id).admin
      user_id = -1
    end
    return Message.find_all_by_to_user(user_id)
  end

  def self.messages_from(user_id)
    if user_id == 'Admin' or user_id == 'admin' or User.find_by_id(user_id).admin
      user_id = -1
    end
    return Message.find_all_by_from_user(user_id)
  end

end
