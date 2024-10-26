from django.shortcuts import render, get_object_or_404, redirect
from productos.models import Producto
from .models import CarritoItem

def agregar_al_carrito(request, producto_id):
    producto = get_object_or_404(Producto, id=producto_id)
    carrito_item, created = CarritoItem.objects.get_or_create(producto=producto)
    carrito_item.cantidad += 1
    carrito_item.save()
    return redirect('ver_carrito')

def ver_carrito(request):
    items = CarritoItem.objects.all()
    total = sum(item.producto.precio * item.cantidad for item in items)
    return render(request, 'carrito/ver_carrito.html', {'items': items, 'total': total})
