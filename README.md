# 🧭 Wanderplan

Prototipo de app para planificar viajes (proyecto APP Viaje): mapa mundial interactivo offline,
115 destinos + creación de destinos propios, planificador con cotización por temporada, viaje
aleatorio, itinerario día a día con horarios editables, reservas precargadas según estilo,
documentos según país de origen, comunidad y **asistente de IA** (botón ✨).

## Desplegar en Vercel
1. [vercel.com/new](https://vercel.com/new) → importa este repositorio.
2. Framework Preset: **Other** · sin build. → **Deploy**.
3. *(Opcional, para IA real)*: Settings → Environment Variables → `ANTHROPIC_API_KEY` = tu clave
   de [console.anthropic.com](https://console.anthropic.com) → Redeploy.
   El asistente ✨ pasará de "modo local" a responder con Claude en tiempo real vía `/api/chat`
   (la clave nunca llega al navegador).

Cada push a `main` redespliega automáticamente.

> ⚠️ Prototipo: los datos de viajes viven en memoria (recargar resetea). Persistencia = siguiente fase.
