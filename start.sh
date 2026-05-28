#!/bin/bash

echo ""
echo " =========================================="
echo "  Local Voice Assistant | Ollama + Llama"
echo " =========================================="
echo ""

# ── Check Ollama is installed ────────────────────────────────
if ! command -v ollama &> /dev/null; then
    echo " [ERROR] ollama not found!"
    echo " Install it with: curl -fsSL https://ollama.com/install.sh | sh"
    exit 1
fi

# ── Start Ollama if not running ──────────────────────────────
if curl -s http://localhost:11434 > /dev/null 2>&1; then
    echo " [OK] Ollama already running on port 11434"
else
    echo " [..] Starting Ollama server..."
    OLLAMA_ORIGINS="*" ollama serve &
    sleep 2
    echo " [OK] Ollama started"
fi

# ── Pull model if missing ────────────────────────────────────
echo ""
echo " [..] Checking for llama3.2:1b model..."
if ! ollama list | grep -q "llama3.2:1b"; then
    echo " [..] Downloading llama3.2:1b (~1.3 GB) — one-time download..."
    ollama pull llama3.2:1b
    echo " [OK] Model ready!"
else
    echo " [OK] Model llama3.2:1b is ready"
fi

# ── Open browser ─────────────────────────────────────────────
echo ""
echo " [..] Opening voice assistant..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$SCRIPT_DIR/index.html"
else
    xdg-open "$SCRIPT_DIR/index.html" 2>/dev/null || \
    firefox "$SCRIPT_DIR/index.html" 2>/dev/null || \
    google-chrome "$SCRIPT_DIR/index.html" 2>/dev/null
fi

echo ""
echo " =========================================="
echo "  Voice assistant is running!"
echo "  - Talk to it in your browser"
echo "  - Keep this terminal open (Ollama server)"
echo "  - Press Ctrl+C to stop Ollama"
echo " =========================================="
echo ""
wait
