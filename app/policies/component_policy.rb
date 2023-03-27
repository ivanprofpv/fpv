class ComponentPolicy < ApplicationPolicy
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
    destroy?
  end

  def update?
    destroy?
  end

  def create?
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
      drone_user = Drone.where('id = ?', record.drone_id).pluck(:user_id).join().to_i
      user.id == drone_user
    end
  end
end