extends Node

## Converts 0.0-1.0 slider value to dB and updates the bus
func set_bus_volume_percent(bus_name: String, percent: float) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	if bus_index != -1:
		# linear_to_db handles the logarithmic math for you
		var db_value = linear_to_db(percent)
		AudioServer.set_bus_volume_db(bus_index, db_value)
