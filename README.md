# SUSE AI Ollama API Examples

## Installation

To set up the project, follow these steps:

1. **Create a virtual environment**:

   ```bash
   python3 -m venv venv
   ```

2. **Activate the virtual environment**:

     ```bash
     source venv/bin/activate
     ```

3. **Install the required packages**:

   ```bash
   pip install -r requirements.txt
   ```

## Setting Up the Environment

Before running the application, you need to create a `.env` file to configure the necessary environment variables.

1. **Create a `.env` file** in the root of your project directory.

2. **Add the following content** to the `.env` file:

   ```plaintext
   OLLAMA_BASE_URL=http://localhost:11434
   LLM_MODEL=llama2:7b
   ```

   You can change the value to point to your specific Ollama server if it is running on a different host or port.

## Usage

You can run the Ollama chat application using the following command:

```bash
python3 ./ollama-chat.py --prompt "Explain to me what Linux is."
```

### Arguments:

- `-h, --help`: Show this help message and exit.
- `-p, --prompt`: The prompt to send to Ollama (required).
- `-b, --base-url`: The base URL for the Ollama server (default from .env).
- `-m, --model`: The model to use (default from .env).

## Example

To run the application with a specific model and prompt, use:

```bash
python3 ./ollama-chat.py --prompt "What is quantum computing?"
```

## Running with OpenTelemetry Collector

To run the application with OpenTelemetry Collector, use the following command to start the collector.  This will start the OpenTelemetry Collector and the application. The application will send traces to the collector, which will then forward them to Jaeger for visualization.  To view the traces, access the Jaeger UI at `http://localhost:16686` in your web browser.

```bash
docker-compose up
```

Then, run the application with the following command to instrument the application and send traces to the collector:

```bash
opentelemetry-instrument --traces_exporter console python3 ollama-chat.py --prompt "What is quantum computing?"
```

For more detailed logs, you can use the following commands to view the live logs from the collector:

```bash
docker-compose logs -f otel-collector
```

To view all logs:

```bash
docker-compose logs otel-collector
```

To view logs from the last minute:

```bash
docker-compose logs --since 1m otel-collector  # last minute