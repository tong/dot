#!/usr/bin/env python3
import os
import json
import requests
import sys

HASS_URL = os.environ.get("HASS_URL", "http://192.168.0.94:8123")
HASS_TOKEN = os.environ.get("HASS_TOKEN")
HASS_TEMP_ENTITY = os.environ.get(
    "HASS_TEMP_ENTITY", "sensor.living_living_room_temperature"
)
HASS_HUM_ENTITY = os.environ.get(
    "HASS_HUM_ENTITY", "sensor.living_living_room_humidity"
)


def get_entity_data(entity_id):
    if not HASS_TOKEN:
        return None
    try:
        url = f"{HASS_URL}/api/states/{entity_id}"
        headers = {
            "Authorization": f"Bearer {HASS_TOKEN}",
            "content-type": "application/json",
        }
        response = requests.get(url, headers=headers, timeout=5)
        response.raise_for_status()
        return response.json()
    except Exception:
        return None


def format_state(data):
    if not data:
        return "?", ""
    state = data.get("state", "unknown")
    try:
        state = f"{float(state):.1f}"
    except (ValueError, TypeError):
        pass
    unit = data.get("attributes", {}).get("unit_of_measurement", "")
    return state, unit


def main():
    if not HASS_TOKEN:
        print(
            json.dumps(
                {"text": "󰟐 !", "tooltip": "HASS_TOKEN not set", "class": "error"}
            )
        )
        return

    temp_data = get_entity_data(HASS_TEMP_ENTITY)
    hum_data = get_entity_data(HASS_HUM_ENTITY)

    temp_val, temp_unit = format_state(temp_data)
    hum_val, hum_unit = format_state(hum_data)

    tooltip_lines = ["<b>  Living Room</b>"]
    has_data = False

    if temp_data:
        tooltip_lines.append(f" Temperature: {temp_val}{temp_unit}")
        has_data = True

    if hum_data:
        tooltip_lines.append(f" Humidity: {hum_val}{hum_unit}")
        has_data = True

    if not has_data:
        print(
            json.dumps(
                {"text": "󰟐 !", "tooltip": "Could not fetch data", "class": "error"}
            )
        )
        return

    print(
        json.dumps(
            {"text": "󰟐", "tooltip": "\n".join(tooltip_lines), "class": "active"}
        )
    )


if __name__ == "__main__":
    main()
