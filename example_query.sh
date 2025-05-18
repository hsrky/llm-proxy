#/usr/bin/bash
export API_HOST=https://localhost/xai
curl -X GET "${API_HOST}/models" -H "Authorization: Bearer ${XAI_API_KEY}"

curl -X GET "${API_HOST}/models/grok-2" -H "Authorization: Bearer ${XAI_API_KEY}"

curl -N -X POST "${API_HOST}/completions" -H "Content-Type: application/json" -H "Authorization: Bearer ${XAI_API_KEY}" -d '{"model":"grok-2", "prompt":"Once upon a time"}'

curl -N -X POST "${API_HOST}/chat/completions" -H "Content-Type: application/json" -H "Authorization: Bearer ${XAI_API_KEY}" -d '{
	"model":"grok-2", 
	"messages":[{"role":"user", "content":"Hello"}],
	"temperature": 0.7
  }'