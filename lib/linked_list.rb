class LinkedList

  def push(value)
    lli= LinkedListItem.new(value)
    if @first_item
      last_item.next_item = lli
    else
      @first_item = lli
    end
  end

  def get(index)
    current_item = @first_item
    index.times do
      current_item = current_item.next_item
    end
    current_item.payload
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
