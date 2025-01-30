import os
import argparse
from dotenv import load_dotenv
from langchain_ollama import OllamaLLM
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

# Load environment variables from .env file
load_dotenv()

# Check for required environment variables
if not os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT"):
    raise ValueError("OTEL_EXPORTER_OTLP_ENDPOINT must be set in .env file")

# Set OpenTelemetry environment variables
os.environ["OTEL_EXPORTER_OTLP_ENDPOINT"] = os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT")
os.environ["OTEL_TRACES_EXPORTER"] = "otlp"
os.environ["OTEL_METRICS_EXPORTER"] = "otlp"
os.environ["OTEL_EXPORTER_OTLP_PROTOCOL"] = "grpc"

# Set up tracing
tracer_provider = TracerProvider()
otlp_exporter = OTLPSpanExporter(
    insecure=True,
)
span_processor = BatchSpanProcessor(otlp_exporter)
tracer_provider.add_span_processor(span_processor)
trace.set_tracer_provider(tracer_provider)

# Get a tracer
tracer = trace.get_tracer(__name__)

# Auto-instrumentation for Requests
RequestsInstrumentor().instrument()

def chat_with_model(prompt, base_url, model_name):
    with tracer.start_as_current_span("chat_with_model") as span:
        # Add attributes to the span
        span.set_attribute("prompt.text", prompt)
        span.set_attribute("model.name", model_name)
        span.set_attribute("base.url", base_url)
        
        try:
            # Create an instance of the Ollama model
            llm = OllamaLLM(model=model_name, base_url=base_url)
            
            # Call the Ollama model
            with tracer.start_as_current_span("ollama.invoke") as invoke_span:
                response = llm.invoke(prompt)
                invoke_span.set_attribute("response.length", len(str(response)))
                return response
                
        except Exception as e:
            span.set_status(trace.Status(trace.StatusCode.ERROR, str(e)))
            raise

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Chat with Ollama LLMs')
    parser.add_argument('-p', '--prompt', type=str, required=True,
                        help='The prompt to send to Ollama (required)')
    parser.add_argument('-b', '--base-url', type=str, default=os.getenv("OLLAMA_BASE_URL"),
                        help='The base URL for the Ollama server (default from .env)')
    parser.add_argument('-m', '--model', type=str, default=os.getenv("DEFAULT_MODEL"),
                        help='The model to use (default from .env)')

    args = parser.parse_args()
    if not args.base_url:
        raise ValueError("Base URL is required in command line or .env file")
    if not args.model:
        raise ValueError("Model is required in command line or .env file")
    response = chat_with_model(args.prompt, args.base_url, args.model)
    print(f"Response: {response}")
