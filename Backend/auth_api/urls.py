
from django.urls import path
from .views import PatientRegisterView, PatientLoginView,ChatAPIView,ReceiveDoctorMessage,GetMessagesForPatient

urlpatterns = [
    path('register/', PatientRegisterView.as_view(), name='patient-register'),
    path('login/', PatientLoginView.as_view(), name='patient-login'),
    path('chat/', ChatAPIView.as_view(), name='chat-api'),
    path('receive_message/',ReceiveDoctorMessage.as_view(), name='receive-message'),
    path('messages/<str:email>/',GetMessagesForPatient.as_view(), name='get-messages'),
    
]
