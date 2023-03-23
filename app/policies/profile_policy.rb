class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
  end
  
  def show_other_profile?
    true
  end

  def show?
    user.admin? || user_author?
  end

  def edit?
    user.admin? || user_author?
  end

  def update?
    user.admin? || user_author?
  end

  def destroy?
    user.admin? || user_author?
  end

  private

  def user_author?
    user == record.user
  end
end