# Aplicación Móvil para Control de LED y Notificaciones

## Descripción

Esta aplicación móvil permite encender y apagar un LED conectado a una tarjeta Arduino mediante Wi-Fi o Bluetooth. Además, envía notificaciones a un smartwatch para informar sobre el estado del LED, mostrando mensajes y animaciones en el smartwatch.

## Funcionalidades

- Conectar con un Arduino a través de Wi-Fi o Bluetooth.
- Enviar comandos para encender o apagar el LED.
- Enviar notificaciones a un smartwatch indicando el cambio de estado del LED.
- Interfaz de usuario intuitiva para el control del LED.

## Requisitos

- Dispositivo móvil con soporte para Bluetooth y Wi-Fi.
- Arduino con LED conectado.
- Módulo Bluetooth (HC-05 o compatible) para Arduino.
- Conexión a internet para enviar notificaciones a Firebase.

## Configuración

1. **Conexión Bluetooth:**
   - Emparejar el dispositivo móvil con el módulo Bluetooth del Arduino.
   - Configurar la comunicación serie en el código del Arduino.

2. **Configuración de Firebase:**
   - Crear un proyecto en Firebase.
   - Configurar Firebase Cloud Messaging (FCM).
   - Integrar Firebase en la aplicación móvil siguiendo la documentación oficial.

3. **Interfaz de Usuario:**
   - Crear botones para encender y apagar el LED.
   - Implementar funciones para enviar los comandos al Arduino.

## Uso

1. Abre la aplicación móvil.
2. Conéctate al módulo Bluetooth del Arduino.
3. Utiliza los botones de la interfaz para encender o apagar el LED.
4. Observa las notificaciones en el smartwatch.

![image](https://github.com/JaredTrOr/led_notificaciones_smartphone/assets/115369767/49814fa0-46e1-407a-91c1-30cdfa0b39a6)
![image](https://github.com/JaredTrOr/led_notificaciones_smartphone/assets/115369767/13ca5768-3bc6-477c-895c-185f30e243cd)
![image](https://github.com/JaredTrOr/led_notificaciones_smartphone/assets/115369767/712ac249-8807-4fb7-97fc-e32b120ec865)




