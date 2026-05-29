#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PYTHON_BIN="$(command -v python3)"

cd "$SCRIPT_DIR" || exit 1

if [ -z "$PYTHON_BIN" ]; then
  echo "python3 was not found on this Mac."
  read -r "?Press Enter to close..."
  exit 1
fi

if [ ! -f ".env.local" ]; then
  echo "Missing .env.local"
  echo ""
  echo "Create a file named .env.local in:"
  echo "$SCRIPT_DIR"
  echo ""
  echo "Use this format:"
  echo 'GEMINI_API_KEY=your_gemini_api_key_here'
  echo 'GEMINI_MODEL=gemini-2.5-flash'
  echo 'PORT=3000'
  echo ""
  read -r "?Press Enter to close..."
  exit 1
fi

source ".env.local"

if [ -z "$GEMINI_API_KEY" ]; then
  echo "GEMINI_API_KEY is empty in .env.local"
  read -r "?Press Enter to close..."
  exit 1
fi

if [ "$GEMINI_API_KEY" = "your_gemini_api_key_here" ]; then
  echo "Replace the placeholder API key in .env.local first."
  read -r "?Press Enter to close..."
  exit 1
fi

echo "Starting Quantum Scope Project Tracker..."
echo "Open http://127.0.0.1:${PORT:-3000} in your browser"
echo ""
"$PYTHON_BIN" server.py
