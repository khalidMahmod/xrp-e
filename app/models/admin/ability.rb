module Admin
  class Ability
    include CanCan::Ability

    def initialize(user)
      return unless user.admin?

      can :read, Order
      can :read, Trade
      can :read, Proof
      can :update, Proof
      can :manage, Member
      can :manage, IdDocument
      can :manage, CurrencyAmount

      can :menu, Deposit
      can :manage, ::Deposits::Bank
      can :manage, ::Deposits::Satoshi
      can :manage, ::Deposits::Ripple
      can :manage, ::Deposits::Litecoin
      can :manage, ::Deposits::Deadal
      can :manage, ::Deposits::Dashcoin
      can :manage, ::Deposits::Stellar
      can :manage, ::Deposits::Tether

      can :menu, Withdraw
      can :manage, ::Withdraws::Bank
      can :manage, ::Withdraws::Satoshi
      can :manage, ::Withdraws::Ripple
      can :manage, ::Withdraws::Litecoin
      can :manage, ::Withdraws::Deadal
      can :manage, ::Withdraws::Dashcoin
      can :manage, ::Withdraws::Stellar
      can :manage, ::Withdraws::Tether
    end
  end
end
