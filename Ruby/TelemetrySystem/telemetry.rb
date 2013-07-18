class TelemetryClient

  attr_reader :online_status

  DIAGNOSTIC_MESSAGE = "AT#UD"

  def initialize
    @online_status = false
    @diagnostic_message_result = ""
  end

  def connect(telemetry_server_connection_string)
    if !telemetry_server_connection_string
      raise "Illegal Argument"
    end

    # simulate the operation on a real modem
    success = rand(10) <= 8
    @online_status = success
  end

  def disconnect
    @online_status = false
  end

  def send(message)
    if !message
      raise "Illegal Argument"
    end

    if message == TelemetryClient::DIAGNOSTIC_MESSAGE
      # simulate a status report
      @diagnostic_message_result = """\
LAST TX rate................ 100 MBPS\r\n
HIGHEST TX rate............. 100 MBPS\r\n
LAST RX rate................ 100 MBPS\r\n
HIGHEST RX rate............. 100 MBPS\r\n
BIT RATE.................... 100000000\r\n
WORD LEN.................... 16\r\n
WORD/FRAME.................. 511\r\n
BITS/FRAME.................. 8192\r\n
MODULATION TYPE............. PCM/FM\r\n
TX Digital Los.............. 0.75\r\n
RX Digital Los.............. 0.10\r\n
BEP Test.................... -5\r\n
Local Rtrn Count............ 00\r\n
Remote Rtrn Count........... 00"""
    end

    # here should go the real Send operation (not needed for this exercise)
  end

  def receive
    if !@diagnostic_message_result
      # simulate a received message (just for illustration - not needed for this exercise)
      message = ""
      messageLength = rand(0, 50) + 60
      i = messageLength
      while(i >= 0)
        message += chr((rand(0, 40) + 86))
        i -= 1
      end
    else
      message = @diagnostic_message_result
      @diagnostic_message_result = ""
    end

    return message
  end

end

class TelemetryDiagnosticControls
  DiagnosticChannelConnectionString = "*111#"

  def initialize
    @telemetry_client = TelemetryClient.new
    @diagnostic_info = ""
  end

  def check_transmission
    @diagnostic_info = ""
    @telemetry_client.disconnect()

    retryLeft = 3
    while ((not @telemetry_client.online_status) and retryLeft > 0)
      @telemetry_client.connect(DiagnosticChannelConnectionString)
      retryLeft -= 1
    end

    if !@telemetry_client.online_status
      raise "Unable to connect."
    end

    @telemetry_client.send(TelemetryClient::DIAGNOSTIC_MESSAGE)
    @diagnostic_info = @telemetry_client.receive()
  end

end


