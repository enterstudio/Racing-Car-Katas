class TurnTicket

  attr_reader :turn_number

  def initialize(turn_number)
    @turn_number = turn_number
  end

end

class TurnNumberSequence

  @@turn_number = -1

  def self.next_turn_number
    @@turn_number += 1
    return @@turn_number
  end

end


class TicketDispenser

  def get_turn_ticket
    newTurnNumber = TurnNumberSequence.next_turn_number()
    newTurnTicket = TurnTicket.new(newTurnNumber)
    return newTurnTicket
  end

end
