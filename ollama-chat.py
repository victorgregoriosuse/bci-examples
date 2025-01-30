import os
import argparse
from dotenv import load_dotenv
from langchain_ollama import OllamaLLM
from opentelemetry.instrumentation.requests import RequestsInstrumentor

# Load environment variables from .env file
load_dotenv()

# Auto-instrumentation for Requests
RequestsInstrumentor().instrument()

def chat_with_model(prompt, base_url, model_name):
    # Create an instance of the Ollama model
    llm = OllamaLLM(model=model_name, base_url=base_url)
    
    # Call the Ollama model
    response = llm.invoke(prompt)  # This will make an HTTP request to the Ollama server
    return response

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Chat with Ollama LLMs')
    parser.add_argument('-p', '--prompt', type=str, required=True,
                        help='The prompt to send to Ollama (required)')
    parser.add_argument('-b', '--base-url', type=str, default=os.getenv("OLLAMA_BASE_URL"),
                        help='The base URL for the Ollama server (default from .env)')
    parser.add_argument('-m', '--model', type=str, default=os.getenv("DEFAULT_MODEL"),
                        help='The model to use (default from .env)')

    args = parser.parse_args()
    response = chat_with_model(args.prompt, args.base_url, args.model)
    print(f"Response: {response}")
