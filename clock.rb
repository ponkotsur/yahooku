require 'clockwork'
include Clockwork

every(3.seconds, 'kokoro') do
  p "test"
end