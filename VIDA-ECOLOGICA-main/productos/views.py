from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from .models import Producto
from .forms import ProductoForm

def lista_productos(request):
    productos = Producto.objects.all()
    if not productos:
        messages.info(request, "No hay productos disponibles en este momento.")
    return render(request, 'productos/lista_productos.html', {'productos': productos})

def detalle_producto(request, id):
    producto = get_object_or_404(Producto, id=id)
    return render(request, 'productos/detalle_producto.html', {'producto': producto})

def crear_producto(request):
    if request.method == 'POST':
        form = ProductoForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Producto creado exitosamente.")
            return redirect('productos:lista_productos')
        else:
            messages.error(request, "Error al crear el producto. Por favor verifica los datos.")
    else:
        form = ProductoForm()
    return render(request, 'productos/crear_producto.html', {'form': form})

def editar_producto(request, id):
    producto = get_object_or_404(Producto, id=id)
    if request.method == 'POST':
        form = ProductoForm(request.POST, instance=producto)
        if form.is_valid():
            form.save()
            messages.success(request, "Producto actualizado exitosamente.")
            return redirect('productos:detalle_producto', id=producto.id)
        else:
            messages.error(request, "Error al actualizar el producto.")
    else:
        form = ProductoForm(instance=producto)
    return render(request, 'productos/editar_producto.html', {'form': form, 'producto': producto})

def eliminar_producto(request, id):
    producto = get_object_or_404(Producto, id=id)
    if request.method == 'POST':
        producto.delete()
        messages.success(request, f"Producto '{producto.nombre}' eliminado correctamente.")
        return redirect('productos:lista_productos')
    return render(request, 'productos/eliminar_producto.html', {'producto': producto})