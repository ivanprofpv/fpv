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
    user.admin? || user_author?
  end

  def update?
    user.admin? || user_author?
  end

  def create?
    true
  end

  def destroy?
    user.admin?
  end

  private

  def user_author?
    user == record.user
  end
end