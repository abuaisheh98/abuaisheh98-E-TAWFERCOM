class ProgressWayChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ProgressWayChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
