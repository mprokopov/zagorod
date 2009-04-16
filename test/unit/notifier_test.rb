require File.dirname(__FILE__) + '/../test_helper'
require 'notifier'

class NotifierTest < Test::Unit::TestCase
  fixtures :lots, :regions, :agencies, :buildings, :buildobjects, :greens, :lotroad_widths, :lotroad_distances, :lotroad_surfaces, :waters, :placements
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"

  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
  end
  def test_newlot
    @lot=lots(:lots_005)
    @expected.set_content_type "text", "html", { "charset" => CHARSET }
    @expected.subject="[ сайт Загород: новый участок ]"
    @expected.body=read_fixture("newlot")
    assert_not_nil Notifier.create_newlot(@lot)
    Notifier.deliver_newlot(@lot)
    assert ActionMailer::Base.deliveries.length>0
  end

  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/notifier/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
