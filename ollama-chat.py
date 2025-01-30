import os
import argparse
from dotenv import load_dotenv
from langchain_ollama import OllamaLLM
from opentelemetry.instrumentation.requests import RequestsInstrumentor

# Load environment variables from .env file
load_dotenv()

# Auto-instrumentation for Requests
RequestsInstrumentor().instrument()

def chat_with_model(prompt, model_name):
    # Create an instance of the Ollama model
    llm = OllamaLLM(model=model_name, base_url=os.getenv("OLLAMA_BASE_URL", "http://localhost:11434"))
    
    # Call the Ollama model
    response = llm.invoke(prompt)  # This will make an HTTP request to the Ollama server
    return response

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Chat with Ollama LLMs')
    parser.add_argument('-p', '--prompt', type=str, default="Explain to me what Linux is.",
                        help='The prompt to send to Ollama')
    parser.add_argument('-b', '--base-url', type=str, default=os.getenv("OLLAMA_BASE_URL", "http://localhost:11434"),
                        help='The base URL for the Ollama server')
    parser.add_argument('-m', '--model', type=str, default="llama2",
                        help='The model to use (e.g., llama2, llama3)')

    args = parser.parse_args()
    response = chat_with_model(args.prompt, args.model)
    print(f"Response: {response}")
