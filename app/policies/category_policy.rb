class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def create?
    admin?
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
end