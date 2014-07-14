class LinkedList

  attr_accessor :size

  def initialize
    @size = 0
  end

  def push(value)
    @size += 1
    lli= LinkedListItem.new(value)
    if @first_item
      last_item.next_item = lli
    else
      @first_item = lli
    end
  end

  def get(index)
    raise IndexError if index < 0
    current_item = @first_item
    index.times do
      if current_item
        current_item = current_item.next_item
      else
        raise IndexError
      end
    end

    current_item.payload
  end

  def last
    return nil if @first_item.nil?
    current_item = @first_item
    until current_item.next_item == nil
      current_item = current_item.next_item
    end
    current_item.payload
  end

  def to_s
    if @size == 0
      "| |"
    elsif @size > 0
      list = []
      @size.times do |i|
        list.push(self.get(i))
      end
    "| "+list.join(', ')+" |"
    end
  end



  private

  def last_item
    current_item = @first_item
    until current_item.last?
      current_item = current_item.next_item
    end
    current_item
  end
end
