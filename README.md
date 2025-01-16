# Ollama API Examples

## Installation

```bash
python3 -mvenv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Usage

### Setting Up the Environment

Before running the application, you need to create a `.env` file to configure the necessary environment variables.

1. **Create a `.env` file** in the root of your project directory.

2. **Add the following content** to the `.env` file:

   ```plaintext
   # OTLP Exporter Endpoint
   OTLP_EXPORTER_ENDPOINT=localhost:4317
   ```

   You can change the `OTLP_EXPORTER_ENDPOINT` value to point to your OpenTelemetry collector if it's running on a different host or port.

### Running the Application

You can run the application using the following command:

```bash
python3 ./ollama-chat.py --model llama3.1 --prompt "Explain to me what Linux is."      
```

### Arguments:

- `-p, --prompt`: The prompt to send to Ollama (default: "Explain to me what Linux is.").
- `-b, --base-url`: The base URL for the Ollama server (default: "http://localhost:11434").
- `-m, --model`: The model to use (e.g., llama2, mistral, codellama).

