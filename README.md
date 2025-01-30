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
   # Base URL for the Ollama server
   OLLAMA_BASE_URL=http://localhost:11434
   ```

   You can change the value to point to your specific Ollama server if it is running on a different host or port.

## Usage

<<<<<<< HEAD
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

=======
You can run the Ollama chat application using the following command:

```bash
python3 ./ollama-chat.py --model llama2 --prompt "Explain to me what Linux is."
```

### Arguments:

- `-h, --help`: Show this help message and exit.
- `-p, --prompt`: The prompt to send to Ollama (default: "Explain to me what Linux is.").
- `-b, --base-url`: The base URL for the Ollama server (default: "http://localhost:11434").
- `-m, --model`: The model to use (e.g., llama2, llama3).

## Example

To run the application with a specific model and prompt, use:

```bash
python3 ./ollama-chat.py --model llama2 --prompt "What is quantum computing?"
```
>>>>>>> main
