from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),  # Página principal
    path('productos/', views.listado_productos, name='listado_productos'),  # Página de listado
]

