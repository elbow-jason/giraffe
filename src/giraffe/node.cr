
class Giraffe::Node
  def initialize()
    @nodes = {} of UInt8 => Node
    @values = Set(UInt64).new
  end

  def search(term : String) : Set(UInt64)?
    search(term.bytes)
  end
  def search(parts : Array(UInt8)) : Set(UInt64)?
    if parts.empty?
      return @values.dup
    end
    first = parts[0]
    next_node = @nodes.fetch(first, nil)
    if next_node.is_a?(Nil)
      return nil
    end
    rest = parts[1..parts.size - 1]
    return next_node.search(rest)
  end

  def add(term : String, value : UInt64) : UInt64
    add(term.bytes, value)
  end
  def add(parts : Array(UInt8), value : UInt64) : UInt64
    if parts.empty?
      @values.add(value)
      return value
    end
    first = parts[0]
    rest = parts[1..parts.size - 1]
    next_node = @nodes.fetch(first, Node.new)
    @nodes[first] = next_node
    next_node.add(rest, value)
  end

  def all_values : Array(UInt64)
    acc : Array(UInt64) = @values.to_a # dup is important here
    @nodes.each_value do |node|
      acc = acc.concat(node.all_values)
    end
    acc
  end

end
