class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
  end
  
  def show_other_profile?
    true
  end

  def show?
    destroy?
  end

  def edit?
    destroy?
  end

  def update?
    destroy?
  end

  def destroy?
    admin? || user_author?
  end

  private

  def admin?
    if user.present?
      user.admin?
    end
  end

  def user_author?
    if user.present?
      user == record.user
    end
  end
end