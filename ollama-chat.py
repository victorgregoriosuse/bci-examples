from langchain_ollama import OllamaLLM
import time
import argparse
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

def measure_ollama_speed(llm, prompt):
    start_time = time.time()
    response = llm.invoke(prompt)
    end_time = time.time()
    
    # Estimate tokens (rough approximation: 4 chars = 1 token)
    tokens = len(response) / 4
    elapsed_time = end_time - start_time
    tokens_per_second = tokens / elapsed_time if elapsed_time > 0 else 0
    
    print(f"Response: {response}\n")
    print(f"Estimated tokens: {tokens:.0f}")
    print(f"Time taken: {elapsed_time:.2f} seconds")
    print(f"Tokens per second: {tokens_per_second:.2f}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Measure Ollama response speed')
    parser.add_argument('-p', '--prompt', type=str, default="Explain to me what Linux is.",
                        help='The prompt to send to Ollama')
    parser.add_argument('-b', '--base-url', type=str, default=os.getenv("OLLAMA_BASE_URL", "http://localhost:11434"),
                        help='The base URL for the Ollama server')
    parser.add_argument('-m', '--model', type=str, default="llama2",
                        help='The model to use (e.g., llama2, mistral, codellama)')
    
    args = parser.parse_args()
    llm = OllamaLLM(model=args.model, base_url=args.base_url)
    measure_ollama_speed(llm, args.prompt)
