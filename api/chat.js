// Función serverless de Vercel: proxy a la API de Anthropic.
// La clave vive en el servidor (variable de entorno ANTHROPIC_API_KEY),
// el navegador nunca la ve. Configurala en Vercel → Settings → Environment Variables.
export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Solo POST' });
  const key = process.env.ANTHROPIC_API_KEY;
  if (!key) return res.status(501).json({ error: 'ANTHROPIC_API_KEY no configurada en Vercel' });
  try {
    const r = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        'x-api-key': key,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({ ...req.body, model: 'claude-haiku-4-5', max_tokens: 400 })
    });
    const data = await r.json();
    return res.status(r.status).json(data);
  } catch (e) {
    return res.status(502).json({ error: String(e) });
  }
}
