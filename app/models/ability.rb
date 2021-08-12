class Ability
    include CanCan::Ability
  
    def initialize(user)
        can :read, ActiveAdmin::Page, :name => "Dashboard"
        if user.role == 'admin'
            can :manage, :all  
        elsif user.role == 'user'
            can :read, :all
            can :create, Category
        else
            # can :manage, Article 
            # can :manage, Category
            can :read, :all
            can :manage,[Article,Category]
        end
    end
  
  end