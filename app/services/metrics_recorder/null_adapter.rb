class MetricsRecorder::NullAdapter
  def track(_label, _value, at: Time.now.utc)
    Rails.logger.info "Sending data into Ether! value is #{value.to_f}"
    # No action
  end
end
