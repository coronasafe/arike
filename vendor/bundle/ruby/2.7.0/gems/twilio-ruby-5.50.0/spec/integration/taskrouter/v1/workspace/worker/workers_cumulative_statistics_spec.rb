##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

require 'spec_helper.rb'

describe 'WorkersCumulativeStatistics' do
  it "can fetch" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.taskrouter.v1.workspaces('WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                           .workers('WKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                           .cumulative_statistics().fetch()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://taskrouter.twilio.com/v1/Workspaces/WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Workers/CumulativeStatistics',
    ))).to eq(true)
  end

  it "receives fetch responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "workspace_sid": "WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Workers/CumulativeStatistics",
          "reservations_created": 100,
          "reservations_accepted": 100,
          "reservations_rejected": 100,
          "reservations_timed_out": 100,
          "reservations_canceled": 100,
          "reservations_rescinded": 100,
          "activity_durations": [
              {
                  "max": 0,
                  "min": 900,
                  "sid": "WAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "friendly_name": "Offline",
                  "avg": 1080,
                  "total": 5400
              },
              {
                  "max": 0,
                  "min": 900,
                  "sid": "WAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "friendly_name": "Busy",
                  "avg": 1012,
                  "total": 8100
              },
              {
                  "max": 0,
                  "min": 0,
                  "sid": "WAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "friendly_name": "Idle",
                  "avg": 0,
                  "total": 0
              },
              {
                  "max": 0,
                  "min": 0,
                  "sid": "WAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "friendly_name": "Reserved",
                  "avg": 0,
                  "total": 0
              }
          ],
          "start_time": "2015-07-30T20:00:00Z",
          "end_time": "2015-07-30T20:00:00Z"
      }
      ]
    ))

    actual = @client.taskrouter.v1.workspaces('WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .workers('WKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .cumulative_statistics().fetch()

    expect(actual).to_not eq(nil)
  end
end