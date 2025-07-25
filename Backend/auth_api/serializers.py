from rest_framework import serializers
from .models import Patient, DoctorMessage
from django.contrib.auth.models import User

class PatientRegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = Patient
        fields = ['email', 'first_name','last_name', 'contactno', 'date_of_birth', 'password']

    def create(self, validated_data):
        password = validated_data.pop('password')
        patient = Patient(**validated_data)
        patient.set_password(password)
        patient.save()
        return patient

class DoctorMessageSerializer(serializers.ModelSerializer):
    patient_email = serializers.EmailField(write_only=True)

    class Meta:
        model = DoctorMessage
        fields = ['patient_email', 'doctor_name', 'message', 'document', 'timestamp']

    def create(self, validated_data):
        email = validated_data.pop('patient_email')
        try:
            patient = Patient.objects.get(email=email)
        except Patient.DoesNotExist:
            raise serializers.ValidationError("Patient with this email does not exist.")
        return DoctorMessage.objects.create(patient=patient, **validated_data)