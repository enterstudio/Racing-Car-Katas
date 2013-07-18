class Sensor
    OFFSET = 16
        
    def pop_next_pressure_psi_value
        pressure_telemetry_value = Sensor.sample_pressure()
        return OFFSET + pressure_telemetry_value
    end

    def self.sample_pressure
        # placeholder implementation that simulate a real sensor in a real tire
        pressure_telemetry_value = 6 * rand * rand
        return pressure_telemetry_value
    end

end

class Alarm

    def initialize
        @low_pressure_threshold = 17
        @high_pressure_threshold = 21
        @sensor = Sensor.new
        @is_alarm_on = false
    end
        
    def check
        psi_pressure_value = @sensor.pop_next_pressure_psi_value()
        if psi_pressure_value < @low_pressure_threshold || @high_pressure_threshold < psi_pressure_value
            @is_alarm_on = true
        end
    end

    def is_alarm_on
        return @is_alarm_on
    end

end
