from functools import wraps
from django.http import JsonResponse
from firebase_admin import auth

def firebase_token_required(get_response):
    def middleware(request):
        token = request.headers.get('Authorization')
        if token:
            try:
                # Verify the token with Firebase
                decoded_token = auth.verify_id_token(token)
                request.user = decoded_token
            except auth.AuthError:
                return JsonResponse({'error': 'Invalid Token'}, status=401)
        else:
            return JsonResponse({'error': 'Authorization header missing'}, status=401)
        
        return get_response(request)

    return middleware
