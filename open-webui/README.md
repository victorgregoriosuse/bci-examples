# Open WebUI API Examples

This repository contains examples for interacting with Open WebUI's API endpoints. The examples demonstrate how to make API calls to chat with models and list available models.

## Installation

```bash
python3 -mvenv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Configuration

Create a `.env` file in the root directory with your credentials:
```bash
JWT_TOKEN=your_jwt_token_here  # Get this from your Open WebUI installation
BASE_URL=https://your-openwebui-instance/    # Your Open WebUI API endpoint
```

## Usage

The `chat-example.py` script demonstrates two main API interactions:

1. List available models:
```bash
python chat-example.py --list-models
```

2. Chat with a model:
```bash
python chat-example.py --model gemma:2b --query "Hello, how are you?"
```

### Optional Parameters

- `-d, --debug`: Enable debug output to see full API responses
- `-m, --model`: Specify which model to use (required for chat)
- `-q, --query`: Your input text (required for chat)
- `-l, --list-models`: List all available models

## API Documentation

For more information about the Open WebUI API endpoints, see the official documentation:
[Open WebUI API Documentation](https://docs.openwebui.com/getting-started/advanced-topics/api-endpoints/)
