##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

require 'spec_helper.rb'

describe 'UserChannel' do
  it "can read" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                             .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                             .user_channels.list()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://ip-messaging.twilio.com/v2/Services/ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Users/USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Channels',
    ))).to eq(true)
  end

  it "receives read_full responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "meta": {
              "page": 0,
              "page_size": 50,
              "first_page_url": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Users/USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels?PageSize=50&Page=0",
              "previous_page_url": null,
              "url": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Users/USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels?PageSize=50&Page=0",
              "next_page_url": null,
              "key": "channels"
          },
          "channels": [
              {
                  "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "service_sid": "ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "channel_sid": "CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "user_sid": "USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "member_sid": "MBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "status": "joined",
                  "last_consumed_message_index": 5,
                  "unread_messages_count": 5,
                  "notification_level": "default",
                  "url": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Users/USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "links": {
                      "channel": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                      "member": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Members/MBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                  }
              }
          ]
      }
      ]
    ))

    actual = @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .user_channels.list()

    expect(actual).to_not eq(nil)
  end

  it "receives read_empty responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "meta": {
              "page": 0,
              "page_size": 50,
              "first_page_url": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Users/USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels?PageSize=50&Page=0",
              "previous_page_url": null,
              "url": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Users/USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels?PageSize=50&Page=0",
              "next_page_url": null,
              "key": "channels"
          },
          "channels": []
      }
      ]
    ))

    actual = @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .user_channels.list()

    expect(actual).to_not eq(nil)
  end

  it "can fetch" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                             .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                             .user_channels('CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').fetch()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://ip-messaging.twilio.com/v2/Services/ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Users/USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Channels/CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    ))).to eq(true)
  end

  it "receives fetch responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "service_sid": "ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "channel_sid": "CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "user_sid": "USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "member_sid": "MBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "status": "joined",
          "last_consumed_message_index": 5,
          "unread_messages_count": 5,
          "notification_level": "default",
          "url": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Users/USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "links": {
              "channel": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              "member": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Members/MBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
          }
      }
      ]
    ))

    actual = @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .user_channels('CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').fetch()

    expect(actual).to_not eq(nil)
  end

  it "can delete" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                             .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                             .user_channels('CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').delete()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'delete',
        url: 'https://ip-messaging.twilio.com/v2/Services/ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Users/USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Channels/CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    ))).to eq(true)
  end

  it "receives delete responses" do
    @holodeck.mock(Twilio::Response.new(
        204,
      nil,
    ))

    actual = @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .user_channels('CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').delete()

    expect(actual).to eq(true)
  end

  it "can update" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                             .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                             .user_channels('CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').update()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'post',
        url: 'https://ip-messaging.twilio.com/v2/Services/ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Users/USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Channels/CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    ))).to eq(true)
  end

  it "receives update_notification_level responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "service_sid": "ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "channel_sid": "CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "user_sid": "USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "member_sid": "MBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "status": "joined",
          "last_consumed_message_index": 5,
          "unread_messages_count": 5,
          "notification_level": "muted",
          "url": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Users/USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "links": {
              "channel": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              "member": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Members/MBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
          }
      }
      ]
    ))

    actual = @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .user_channels('CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').update()

    expect(actual).to_not eq(nil)
  end

  it "receives update_last_consumed_message_index responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "service_sid": "ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "channel_sid": "CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "user_sid": "USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "member_sid": "MBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "status": "joined",
          "last_consumed_message_index": 10,
          "unread_messages_count": 5,
          "notification_level": "muted",
          "url": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Users/USaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "links": {
              "channel": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              "member": "https://ip-messaging.twilio.com/v2/Services/ISaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Channels/CHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Members/MBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
          }
      }
      ]
    ))

    actual = @client.ip_messaging.v2.services('ISXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .users('USXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                    .user_channels('CHXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').update()

    expect(actual).to_not eq(nil)
  end
end