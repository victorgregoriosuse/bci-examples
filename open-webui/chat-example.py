import requests
import os
import sys
import argparse
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

def parse_args():
    parser = argparse.ArgumentParser(description='API Test Script')
    parser.add_argument('-m', '--model', help='Model name to use for the API request')
    parser.add_argument('-q', '--query', help='Query to send to the model')
    parser.add_argument('-d', '--debug', action='store_true', help='Enable debug output')
    parser.add_argument('-l', '--list-models', action='store_true', help='List available models')
    return parser, parser.parse_args()

def get_env_vars():
    jwt_token = os.getenv('JWT_TOKEN')
    base_url = os.getenv('BASE_URL')

    if jwt_token is None:
        print("Error: JWT_TOKEN not found in .env file")
        sys.exit(1)

    if base_url is None:
        print("Error: BASE_URL not found in .env file")
        sys.exit(1)

    return jwt_token, base_url

def chat_with_model(base_url, token, model, query):
    url = f"{base_url}/api/chat/completions"
    headers = {
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    }
    payload = {
        'model': model,
        'messages': [{'role': 'user', 'content': query}]
    }
    response = requests.post(url, headers=headers, json=payload)
    return response.json()

def list_models(base_url, token):
    url = f"{base_url}/api/models"
    headers = {
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    }
    response = requests.get(url, headers=headers)
    return response.json()

def main():
    parser, args = parse_args()
    jwt_token, base_url = get_env_vars()
    
    if args.list_models:
        models = list_models(base_url, jwt_token)
        if args.debug:
            print("Debug - Full response:", models)
        for model_info in models['data']:
            print(f"- {model_info['id']} ({model_info['ollama']['details'].get('parameter_size', 'unknown size')})")
    else:
        # Validate required args for chat
        if not args.model or not args.query:
            parser.error("--model and --query are required when not using --list-models")
        
        response = chat_with_model(base_url, jwt_token, args.model, args.query)
        if args.debug:
            print("Debug - Full response:", response)
            
        if not response.get('choices'):
            print("Error: Unexpected response format")
            sys.exit(1)
        
        try:
            print(response['choices'][0]['message']['content'])
        except KeyError as e:
            print(f"Error: Unexpected response structure: {e}")
            if args.debug:
                print("Response:", response)
            sys.exit(1)

if __name__ == "__main__":
    main()