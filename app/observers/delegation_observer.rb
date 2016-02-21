class DelegationObserver < Mongoid::Observer
  def after_save(delegation)
    author   = delegation.author
    proposal = delegation.proposal
    delegate = delegation.delegate

    author.delegates << delegate
    proposal.delegates << delegate
  end

  def before_destroy(delegation)
    author   = delegation.author
    proposal = delegation.proposal
    delegate = delegation.delegate

    author.delegates.delete(delegate) unless author.delegates.empty?
    proposal.delegates.delete(delegate) unless proposal.delegates.empty?
  end
end
