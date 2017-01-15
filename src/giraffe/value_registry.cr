
class Giraffe::ValueRegistry(T)
  def initialize()
    @map = {} of T => UInt64
    @inverse_map = {} of UInt64 => T
    @counter = 0_u64
  end

  def add(value : T) : UInt64
    found = get_by_value(value)
    if found.is_a?(Nil)
      id = increment
      @map[value] = id
      @inverse_map[id] = value
      id
    else
      found
    end
  end

  def get_by_value(value : T) : UInt64?
    @map.fetch(value, nil)
  end

  def get_by_value_id(id : UInt64) : T?
    @inverse_map.fetch(id, nil)
  end

  private def increment : UInt64
    output = @counter
    @counter = @counter + 1_u64
    output
  end
end
