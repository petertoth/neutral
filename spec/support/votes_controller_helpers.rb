module VotesControllerHelpers
  def create(voteable)
    xhr :post, :create, 
      vote: { 
        voteable_type: voteable.class.name,
        voteable_id: voteable.id,
        value: rand(0..1)
      } 
  end

  def update(vote, duplicate=false)
    xhr :patch, :update, id: vote.id, value: value(vote.value, duplicate)
  end

  def destroy(vote)
    xhr :delete, :destroy, id: vote.id
  end

  private
  def value(val, duplicate)
    return val if duplicate
    val == 1 ? 0 : 1
  end
end
