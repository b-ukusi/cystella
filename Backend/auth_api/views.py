import os
from django.http import JsonResponse
import openai
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import PatientRegisterSerializer,DoctorMessageSerializer
from .models import DoctorMessage, Patient
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import authenticate
from django.conf import settings
from rest_framework_simplejwt.tokens import RefreshToken
import requests



class PatientRegisterView(APIView):
    def post(self, request):
        serializer = PatientRegisterSerializer(data=request.data)
        if serializer.is_valid():
            patient = serializer.save()
            refresh = RefreshToken.for_user(patient)
            try:
                doctor_api_url = 'http://127.0.0.1:8000/add_patient/'
                doctor_payload = {
                    "first_name": patient.first_name,
                    "last_name": patient.last_name,
                    "email": patient.email,
                    "contactno": patient.contactno,
                    "date_of_birth": str(patient.date_of_birth),
                    "avatar": "👤"
                }

                doctor_response = requests.post(doctor_api_url, json=doctor_payload, timeout=5)

                print("👨‍⚕️ Doctor system sync response:", doctor_response.status_code)
                if doctor_response.status_code != 201:
                    print("⚠️ Doctor system responded with error:", doctor_response.text)

            except Exception as e:
                print("❌ Could not sync patient to doctor system:", e)

            return Response({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
                'message': 'Registration successful'
            }, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class PatientLoginView(APIView):
    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')
        patient = authenticate(request, username=email, password=password)

        
        if patient is not None:
            refresh = RefreshToken.for_user(patient)
            return Response({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
                'message': 'Login successful'
            })
        return Response({'error': 'Invalid email or password'}, status=status.HTTP_401_UNAUTHORIZED)

class ChatAPIView(APIView):
    def post(self, request):
        user_message = request.data.get("message")

        if not user_message:
            return Response({"error": "Message is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            
            openai.api_key = settings.OPENAI_API_KEY  # Ensure you have set this environment variable in a .env file for security purposes

            if not settings.OPENAI_API_KEY:
                return Response({"error": "DEBUG: API key missing"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            

            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": "You are a helpful assistant for a medical app."},
                    {"role": "user", "content": user_message},
                ]
            )

            assistant_reply = response.choices[0].message["content"]

            return Response({"reply": assistant_reply})
        
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class ReceiveDoctorMessage(APIView):
    def post(self, request):
        serializer = DoctorMessageSerializer(data=request.data)
        if serializer.is_valid():
            print("✅ Valid data:", serializer.validated_data)
            serializer.save()
            return Response({"detail": "Message received successfully."}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class GetMessagesForPatient(APIView):
    def get(self, request, email):
        messages = DoctorMessage.objects.filter(patient__email=email).order_by('-timestamp')
        serializer = DoctorMessageSerializer(messages, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)