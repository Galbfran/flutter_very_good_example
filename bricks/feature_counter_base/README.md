# Brick `feature_counter_base`

Plantilla alineada con el feature `example` del repo: capas **presentación → cubit → dominio → datos** (API + interceptor mock + DTO).

## Requisitos

- [Mason CLI](https://pub.dev/packages/mason_cli): `dart pub global activate mason_cli`

## Uso

Desde la raíz del proyecto Flutter:

```sh
mason get
mason make feature_counter_base
```

Respondé el nombre del feature en **snake_case** (ej. `invoice`) y el **package name** del `pubspec` si no es el default.

## Después de generar

1. Ejecutá **codegen** del DTO:  
   `dart run build_runner build --delete-conflicting-outputs`
2. Registrá el **repositorio** en `App` (u otro scope), como con `ExampleRepository`.
3. Añadí **ruta** en `app_router.dart` / `app_routes.dart` si la pantalla es navegable.
4. **l10n:** la plantilla usa textos en inglés en código para compilar sin tocar ARB; migrá a `AppLocalizations` y claves en `lib/localization/arb/` (ver feature `example`).
5. Los archivos bajo `test/features/<feature>/` son **esqueleto**; implementá tests siguiendo `test/features/example/`.

## Tests

Este brick genera la **misma jerarquía de carpetas** en `test/features/` que el feature de referencia del repo (`example`), con `main` vacío o placeholders. No sustituye los tests reales ya escritos para ese feature.
