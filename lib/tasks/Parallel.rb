require "parallel"
require 'benchmark'
require "secure random"

id = 0
count = 0

exec_time = Benchmark.realtime do

  Parallel.each([*1..10], in_processes: 4) {|i|
    id = i

  }
end
puts exec_time
puts count