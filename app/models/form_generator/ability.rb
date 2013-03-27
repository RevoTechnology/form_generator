module FormGenerator
  class Ability

    def initialize(user)
      user ||= User.new
      organization = user.organization
      if user.organization_admin?
        if organization.system?
          can :manage, :all
          can :read, :all
          cannot_confirm_anything
        else
          organization_admin_manage_rights(:organization_id => user.organization_id)
          organization_admin_read_rights(:organization_id => user.organization_id)
        end
      elsif user.admin?
        if organization.system?
          can :manage, Order
          can_manage_content
          cannot_confirm_anything 
          admin_read_rights
        else
          can :manage, Order, :organization =>{:id => user.organization_id}
          can_manage_content(:organization => {:id => user.organization_id})
          cannot_confirm_anything
          admin_read_rights(:organization => {:id => user.organization_id})
        end
      else
        simple_user_manage_rights :organization =>{:id => user.organization_id}
        simple_user_read_rights(:organization => {:id => user.organization_id})
      end

      if user.demo?
        if user.organization_admin?
          organization_admin_manage_rights(:organization_id => user.organization_id)
          organization_admin_read_rights(:organization_id => user.organization_id)
        elsif user.admin?
          can :manage, Order, :organization_id => user.organization_id
          can_manage_content(:organization => {:id => user.organization_id})
          can_read_content(:organization => {:id => user.organization_id})
        else
          simple_user_manage_rights :organization =>{:id => user.organization_id}
          simple_user_read_rights(:organization => {:id => user.organization_id})
        end
      end

      if user.supervisor?
        supervisor_manage_rights(:organization => {:id => user.organization_id})
        supervisor_read_rights :organization => {:id => user.organization_id}
      end
    end

    ##################
    # MANAGE RIGHTS #
    ##################

    def can_manage_content params={}
      can :manage, Field, params
      can :manage, Category, params
      can :manage, Validation, params
      can :manage, Skin, params
    end

    def organization_admin_manage_rights params={}
      can :manage, User, params
      can :manage, Order, params
      can_manage_content(params)
      cannot_confirm_anything
    end

    def simple_user_manage_rights params
      can :manage, Order, params
      cannot_confirm_anything 
    end

    def supervisor_manage_rights params
      can :manage, User, params
      can :manage, Order, params
      can_manage_content(params)
      can :confirm_publishing, Order, params
      can :confirm_deleting, Order, params
    end

    ##################
    # READ RIGHTS #
    ##################

    def organization_admin_read_rights params={}
      can_read_content params
      can :read, User, params
      can :read, Order, params
    end


    def simple_user_read_rights params
      can :read, Order, params
    end

    def admin_read_rights params
      can_read_content params
      can :read, Order, params
    end

    def can_read_content params={}
      can :read, Field, params
      can :read, Category, params
      can :read, Validation, params
      can :read, Skin, params
    end

    def supervisor_read_rights params
      can :read, User, params
      can :read, Order, params
      can_read_content(params)
    end

    def cannot_confirm_anything params={}
      cannot :confirm_publishing, Order, params
      cannot :confirm_deleting, Order, params
    end

  end
end