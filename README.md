# cinemapedia

## Dev

1. Copiar el .env.template y renombrarlo a .env
2. Cambiar las variables de entorno (The MovieDB)
3. Si hay cambios en la entidad, hay que ejecutar el comando

```!#bash
  flutter pub run build_runner build
```

## Prod

Para cambiar el nombre de la aplicación:
flutter pub run change_app_package_name:main com.dominio.nombreaplicacion
