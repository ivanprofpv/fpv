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
    update?
  end

  def update?
    user.admin? || user_author?
  end

  def create?
    user.admin? || user_author?
  end

  def destroy?
    user.admin? || user_author?
  end

  private

  def user_author?
    drone_user = Drone.where('id = ?', record.drone_id).pluck(:user_id).join().to_i

    user.id == drone_user
  end
end