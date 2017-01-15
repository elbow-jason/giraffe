
class Giraffe::Graph(T)

  def initialize()
    @registry = Giraffe::ValueRegistry(T).new
    @root = Giraffe::Node.new
  end

  def add(key : String, value : T) : T?
    if value.is_a?(T)
      value_id = @registry.add(value)
      @root.add(key, value_id)
      value
    else
      nil
    end
  end

  def search(term : String) : Array(T)?
    found = @root.search(term)
    if found.is_a?(Set(UInt64))
      keep = found.to_a.map do |value_id|
        @registry.get_by_value_id(value_id)
      end
      keep.compact
    else
      nil
    end
  end

end
