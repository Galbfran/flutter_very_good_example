# Feature: {{name.snakeCase()}}

Generado con Mason (`feature_counter_base`). Misma forma que el feature `example`: **presentación → cubit → dominio → datos** (Dio + DTO + interceptor mock).

## Pasos posteriores

1. `dart run build_runner build --delete-conflicting-outputs`
2. Registrar `{{name.pascalCase()}}Repository` en `App` (p. ej. `Api{{name.pascalCase()}}Repository`).
3. Añadir ruta en `core/router` si corresponde.
4. Sustituir textos en widgets por `AppLocalizations` y entradas ARB (ver feature `example` del repo).

## Tests

Estructura espejo en `test/features/{{name.snakeCase()}}/`: implementá siguiendo `test/features/example/`.
