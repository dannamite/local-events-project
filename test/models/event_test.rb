require_relative '../test_helper'

class EventTest < ActiveSupport::TestCase

  test "profane name" do
    Event.word_list = %w(Voldemort)
    badEvent = Event.new
    badEvent.name = 'Voldemort'
    refute badEvent.valid?
  end

end
