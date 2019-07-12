#!/bin/sh

curl -X POST "https://api.datadoghq.com/api/v1/dashboard?api_key=${api_key}&application_key=${app_key}" -i -H "Content-type: application/json" -d @dashboard.json
