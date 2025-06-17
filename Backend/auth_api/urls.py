
from django.urls import path
from .views import PatientRegisterView, PatientLoginView,ChatAPIView

urlpatterns = [
    path('register/', PatientRegisterView.as_view(), name='patient-register'),
    path('login/', PatientLoginView.as_view(), name='patient-login'),
    path('chat/', ChatAPIView.as_view(), name='chat-api'),
    
]
