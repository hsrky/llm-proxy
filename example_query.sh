#/usr/bin/bash
curl -k -X GET "https://localhost:8443/xai/models" -H "Authorization: Bearer ${XAI_API_KEY}"

curl -k -X GET "https://localhost:8443/xai/models/grok-2" -H "Authorization: Bearer ${XAI_API_KEY}"

curl -k -N -X POST "https://localhost:8443/xai/completions" -H "Content-Type: application/json" -H "Authorization: Bearer ${XAI_API_KEY}" -d '{"model":"grok-2", "prompt":"Once upon a time"}'

curl -k -N -X POST "https://localhost:8443/xai/chat/completions" -H "Content-Type: application/json" -H "Authorization: Bearer ${XAI_API_KEY}" -d '{
	"model":"grok-2", 
	"messages":[{"role":"user", "content":"Hello"}],
	"temperature": 0.7
  }'