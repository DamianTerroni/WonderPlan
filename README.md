# Wanderplan — despliegue en Vercel

App de planificación de viajes (prototipo v1.9). Un solo archivo estático: `index.html`.

## Opción A — Vercel CLI (2 minutos)
1. Instalá el CLI:  `npm i -g vercel`
2. Dentro de esta carpeta:  `vercel`
   - Iniciá sesión cuando lo pida (abre el navegador).
   - Aceptá los valores por defecto (proyecto nuevo, sin build).
3. Para publicar en producción:  `vercel --prod`
   → Te da una URL tipo `https://wanderplan.vercel.app`

## Opción B — GitHub + Vercel
1. Subí esta carpeta a un repo de GitHub.
2. En vercel.com → Add New → Project → importá el repo.
3. Framework preset: **Other** (sin build). Deploy.
   Cada push al repo redespliega solo.

## Nota
Los datos del prototipo viven en memoria: cada recarga resetea viajes guardados
y destinos creados. La persistencia real (backend) es el siguiente paso del proyecto.
