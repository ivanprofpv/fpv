class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
  end
  
  def show_other_profile?
    true
  end

  def buttons_other_profile?
    user_author?
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

  # def user_not_author_profile?
  #   if user.present?
  #     user != record.user
  #   end
  # end
end