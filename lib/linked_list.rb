class LinkedList

  attr_accessor :size

  def initialize(*value)
    @size = 0
    if value.length > 0
      value.each { |val| push(val) }
    end
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

  def [](index)
    get(index)
  end

  def []=(index, value)
    lli = get_list_item(index)
    lli.payload = value
  end

  def get_list_item(index)
    raise IndexError if index < 0
    current_item = @first_item
    index.times do
      raise IndexError if current_item.nil?
      current_item = current_item.next_item
    end
    current_item
  end

  def delete(index)
    @size -= 1
    if index == 0
      @first_item = get_list_item(1)
    else
      deleted = get_list_item(index)
      prev = get_list_item(index - 1)
      new_next = get_list_item(index + 1)
      prev.next_item = new_next
    end
  end

  def index(value)
    if @size == 0
      return nil
    end
    @size.times do |i|
      if get_list_item(i).payload == value
        return i
      elsif i == @size - 1
        return nil
      end
    end
  end

  def sorted?
    current_item = @first_item
    if @size <= 1
      true
    else
      until current_item.last?
        return false if current_item > current_item.next_item
        current_item = current_item.next_item
      end
      true
    end
  end

  def sort!
    current_item = @first_item
    until sorted?
      result = current_item <=> current_item.next_item
      if result == 1
        index = index(current_item.payload)
        swap_with_next(index)
        sort!
      else
        current_item = current_item.next_item
      end
    end
    self.to_s
  end

  def swap_with_next(i)
    raise IndexError if i >= self.size - 1
    current_item = self.get_list_item(i)
    second_item = current_item.next_item

    if i > 0
      self.get_list_item(i-1).next_item = second_item
    elsif i == 0
      @first_item = second_item
    end

    if second_item.last?
      current_item.next_item = nil
    else
      current_item.next_item = second_item.next_item
    end

    second_item.next_item = current_item
    swapped = true
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
