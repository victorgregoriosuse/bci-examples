from langchain_ollama import OllamaLLM
import time
import os
import argparse
import os
from dotenv import load_dotenv
from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor

# Load environment variables from .env file
load_dotenv()

# Initialize OpenTelemetry
resource = Resource.create({"service.name": "ollama-chat-service"})
tracer_provider = TracerProvider(resource=resource)
trace.set_tracer_provider(tracer_provider)

# Get the OTLP exporter endpoint from the environment variable
otlp_exporter_endpoint = os.getenv("OTLP_EXPORTER_ENDPOINT", "localhost:4317")

# Set up the OTLP exporter
otlp_exporter = OTLPSpanExporter(endpoint=otlp_exporter_endpoint, insecure=True)
span_processor = BatchSpanProcessor(otlp_exporter)
tracer_provider.add_span_processor(span_processor)

# Create a tracer
tracer = trace.get_tracer(__name__)

def chat_with_model(llm, prompt):
    with tracer.start_as_current_span("chat_with_model"):
        start_time = time.time()        # Start timing the API call
        response = llm.invoke(prompt)   # Call the Ollama API
        end_time = time.time()          # End timing the API call
        
        # Calculate elapsed time
        elapsed_time = end_time - start_time
        
        # Assuming the response contains a 'token_count' key
        token_count = response.get('token_count', None)
        
        if token_count is None:
            # Fallback to rough estimation if token count is not provided
            token_count = len(response) / 4  # Rough estimation
        
        # Log the results
        print(f"Response: {response}\n")
        print(f"Estimated tokens: {token_count:.0f}")
        print(f"Time taken: {elapsed_time:.2f} seconds")
        print(f"Tokens per second: {token_count / elapsed_time:.2f}" if elapsed_time > 0 else "Tokens per second: 0.00")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Measure Ollama response speed and tokens used')
    parser.add_argument('-p', '--prompt', type=str, default="Explain to me what Linux is.",
                        help='The prompt to send to Ollama')
    parser.add_argument('-b', '--base-url', type=str, default=os.getenv("OLLAMA_BASE_URL", "http://localhost:11434"),
                        help='The base URL for the Ollama server')
    parser.add_argument('-m', '--model', type=str, default="llama2",
                        help='The model to use (e.g., llama2, mistral, codellama)')
    
    args = parser.parse_args()
    llm = OllamaLLM(model=args.model, base_url=args.base_url)
    chat_with_model(llm, args.prompt)
