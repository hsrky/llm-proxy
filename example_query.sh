#/usr/bin/bash
curl -X GET "http://localhost:8000/xai/models" -H "Authorization: Bearer ${XAI_API_KEY}"

curl -X GET "http://localhost:8000/xai/models/grok-2" -H "Authorization: Bearer ${XAI_API_KEY}"

curl -N -X POST "http://localhost:8000/xai/completions" -H "Content-Type: application/json" -H "Authorization: Bearer ${XAI_API_KEY}" -d '{"model":"grok-2", "prompt":"Once upon a time"}'

curl -N -X POST "http://localhost:8000/xai/chat/completions" -H "Content-Type: application/json" -H "Authorization: Bearer ${XAI_API_KEY}" -d '{
	"model":"grok-2", 
	"messages":[{"role":"user", "content":"Hello"}],
	"temperature": 0.7
  }'