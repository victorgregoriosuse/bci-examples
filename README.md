# Ollama API Examples

## Installation

```bash
python3 -mvenv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Usage


```bash
python3 ./ollama-chat.py --url http://localhost:11434 --model llama3.1 --prompt "Explain to me what Linux is."      

Arguments:
  -h, --help       show this help message and exit
  --prompt PROMPT  The prompt to send to Ollama
  --base-url URL   The URL for the Ollama server
  --model MODEL    The model to use (e.g., llama2, mistral, codellama)
```