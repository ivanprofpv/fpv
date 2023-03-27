class DronePolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def edit?
    admin? || user_author?
  end

  def update?
    admin? || user_author?
  end

  def create?
    true
  end

  def destroy?
    admin?
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