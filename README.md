# 🎙️ Local Voice Assistant

A fully offline, browser-based voice assistant that runs entirely on your laptop using **Ollama** and a local LLM. No API key, no cloud, no internet required after setup.

```
You speak → Speech-to-Text → Local LLM → Text-to-Speech → You hear
```

![Pipeline](https://img.shields.io/badge/STT-Web%20Speech%20API-blue) ![LLM](https://img.shields.io/badge/LLM-Ollama%20Local-green) ![TTS](https://img.shields.io/badge/TTS-Web%20Speech%20API-blue) ![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## ✨ Features

- 🎤 **Speech-to-Text** — browser's built-in Web Speech API (no external service)
- 🧠 **Local LLM** — Llama 3.2, Phi-3, Gemma 2, Mistral and more via Ollama
- 🔊 **Text-to-Speech** — browser's built-in Speech Synthesis (no external service)
- 💬 **Conversation memory** — remembers context within the session
- 🔄 **Model switcher** — swap models from the UI dropdown
- 📴 **100% offline** — nothing leaves your machine after setup
- 🪟 **Works on Windows, Mac, Linux**

---

## 🚀 Quick Start

### Step 1 — Install Ollama

| OS | Command |
|---|---|
| **Windows** | Download installer from [ollama.com](https://ollama.com/download) |
| **Mac/Linux** | `curl -fsSL https://ollama.com/install.sh \| sh` |

> **Windows tip:** If you install to a custom folder (e.g. `D:\Ollama`), add it to PATH:
> ```
> setx PATH "%PATH%;D:\Ollama"
> ```

### Step 2 — Download a model

This app works with **any model available on Ollama** — over 100+ models from Meta, Google, Microsoft, Mistral and more. You can install as many as you like and switch between them in the app's dropdown.

The model I used while building this project is **`llama3.2:1b`** — it's a great starting point for laptops with limited RAM since it only needs ~1.3 GB and runs fast on CPU:

```bash
ollama pull llama3.2:1b
```

**Choose the right model for your hardware:**

| Model | Size | RAM needed | Best for |
|---|---|---|---|
| `llama3.2:1b` ⭐ | 1.3 GB | 4 GB | Low-end laptops, fastest responses |
| `llama3.2:3b` | 2.0 GB | 6 GB | Better quality, still fast on CPU |
| `phi3:mini` | 2.5 GB | 6 GB | Microsoft's efficient small model |
| `gemma2:2b` | 2.0 GB | 6 GB | Google's compact model, very capable |
| `mistral:7b` | 5.0 GB | 10 GB | High quality, needs a good laptop |
| `llama3.1:8b` | 5.5 GB | 12 GB | Best quality for CPU-only machines |
| `deepseek-r1:7b` | 5.0 GB | 10 GB | Strong reasoning tasks |

> **Not sure which to pick?** Start with `llama3.2:1b`. If your laptop has 8+ GB of free RAM and you want smarter responses, try `phi3:mini` or `gemma2:2b` next.

Browse the full model library at **[ollama.com/library](https://ollama.com/library)** — pull any model with `ollama pull <model-name>` and it immediately appears as an option in the app.

### Step 3 — Start Ollama with CORS enabled

**Windows:**
```cmd
set OLLAMA_ORIGINS=*
ollama serve
```

**Mac/Linux:**
```bash
OLLAMA_ORIGINS="*" ollama serve
```

> Keep this terminal window open while using the app.

### Step 4 — Open the app

Double-click `index.html` — it opens in your browser.  
Click the **orb** and start talking!

---

## ⚡ One-click launcher (easier)

Instead of steps 3 & 4, just run the launcher script:

**Windows:**
```
double-click start.bat
```

**Mac/Linux:**
```bash
chmod +x start.sh
./start.sh
```

The launcher automatically:
- Checks if Ollama is installed
- Starts the Ollama server with CORS enabled
- Downloads the model if missing
- Opens the app in your browser

---

## 🗂️ Project Structure

```
voice-llm-assistant/
├── index.html      # Main app — open this in Chrome/Edge
├── start.bat       # One-click launcher for Windows
├── start.sh        # One-click launcher for Mac/Linux
└── README.md       # This file
```

---

## 🔧 Troubleshooting

### "Failed to fetch" error
Ollama is running but CORS is blocked. Restart with:
```cmd
set OLLAMA_ORIGINS=*
ollama serve
```

### "Ollama error 404" error
The model isn't downloaded yet. Run:
```bash
ollama pull llama3.2:1b
```

### "ollama is not recognized"
Ollama isn't in your PATH. Either use the full path:
```cmd
D:\Ollama\ollama.exe serve
```
Or add it to PATH permanently:
```cmd
setx PATH "%PATH%;D:\Ollama"
```

### "Only one usage of each socket address" error
Ollama is already running — this is fine! Just open `index.html`.

### Mic not working
- Use **Chrome or Edge** (Firefox has limited Web Speech API support)
- Allow microphone access when the browser asks
- Open the app as a local file (`file://`) not from a web server

### Slow responses
- Use a smaller model: `llama3.2:1b` is fastest on CPU
- Close other apps to free up RAM
- A 1B model needs ~2 GB RAM; 7B needs ~8 GB RAM

---

## 🧩 How It Works

```
┌─────────────────────────────────────────────────┐
│                  Your Browser                    │
│                                                  │
│  🎤 Web Speech API  →  text transcript           │
│         ↓                                        │
│  📡 fetch() to localhost:11434/api/chat          │
│         ↓                                        │
│  🧠 Ollama (local server) runs the LLM           │
│         ↓                                        │
│  🔊 Web Speech Synthesis reads the reply         │
└─────────────────────────────────────────────────┘
```

All three stages run locally:
- **STT** — `window.SpeechRecognition` (Chrome/Edge built-in)
- **LLM** — Ollama's `/api/chat` endpoint on `localhost:11434`
- **TTS** — `window.speechSynthesis` (browser built-in)

---

## 🔄 Using Any Model

Ollama supports **100+ open-source models**. Pull any of them and they'll instantly work with this app — no code changes needed.

```bash
# Small & fast (good for any laptop)
ollama pull llama3.2:1b      # ⭐ recommended starting point
ollama pull gemma2:2b
ollama pull phi3:mini

# Medium (needs 8+ GB RAM)
ollama pull mistral:7b
ollama pull llama3.1:8b

# Specialised
ollama pull deepseek-r1:7b   # strong reasoning
ollama pull codellama:7b     # coding assistant
```

Then select the model from the **dropdown in the app** — no restart needed.

Browse all available models at [ollama.com/library](https://ollama.com/library).

> 💡 **My setup:** I built and tested this on a regular laptop using `llama3.2:1b` — it runs entirely on CPU, no GPU required, and responds in a few seconds.

---

## 🛠️ Customising the System Prompt

Edit the `system` message in `index.html` to change the assistant's behaviour:

```javascript
{
  role: 'system',
  content: 'You are a helpful voice assistant. Give concise answers of 1-3 sentences...'
}
```

Examples:
- `'You are a pirate. Answer everything in pirate speak.'`
- `'You are a Python tutor. Help me learn programming.'`
- `'You are a doctor. Give brief medical explanations in simple terms.'`

---

## 📋 Requirements

- Windows 10/11, macOS 12+, or Linux
- 4 GB RAM minimum (8 GB recommended for 7B models)
- Chrome or Edge browser
- ~1.5 GB disk space for Ollama + model

---

## 📄 License

MIT — free to use, modify, and share.

---

## 🙏 Built With

- [Ollama](https://ollama.com) — local LLM runtime
- [Llama 3.2](https://ollama.com/library/llama3.2) — Meta's open-source LLM
- [Web Speech API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Speech_API) — browser STT + TTS
