class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    
    user ||= User.new # guest user (not logged in)
    if user.role? :administrator
        can :manage, :all
    elsif user.role? :user
        can :update, :assay
        can :update, :clone
        can :manage, :clone_attachment
        can :manage, :clone_batch
        can :manage, :clone_batch_attachment
        can :manage, :sequencing
        can :manage, :pcr_colony
        can :manage, :qc_attachment
        can :manage, :clone_batch_as_plasmid_attchment
        can :manage, :plasmid_batch
        can :manage, :plasmid_batch_attachment
        can :manage, :plasmid_batch_qc
        can :manage, :plasmid_batch_qc_attachment
        can :update, :production
        can :update, :virus_production
        cannot :update_row_order, :assay
        cannot :destroy, :virus_production
        cannot :destroy, :clone
        cannot :update, :clone_batch
    else
        can :read, :all
    end
  end
end
