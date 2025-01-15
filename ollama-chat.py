from langchain_ollama import OllamaLLM
import time
import argparse

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
    parser.add_argument('--prompt', type=str, default="Explain to me what Linux is.",
                      help='The prompt to send to Ollama')
    parser.add_argument('--url', type=str, default="http://localhost:11434",
                      help='The URL for the Ollama server')
    parser.add_argument('--model', type=str, default="llama2",
                      help='The model to use (e.g., llama2, mistral, codellama)')
    
    args = parser.parse_args()
    llm = OllamaLLM(model=args.model, base_url=args.url)
    measure_ollama_speed(llm, args.prompt)
