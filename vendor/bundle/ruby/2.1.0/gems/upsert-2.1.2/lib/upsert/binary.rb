class Upsert
  # A wrapper class for binary strings so that Upsert knows to escape them as such.
  #
  # Create them with +Upsert.binary(x)+
  #
  # @private
  Binary = Struct.new(:value)
end
