# Checklist de implementación — base Very Good + router + red

Marca cada ítem al completarlo. Pensado para el repo `flutter_very_good_example` y equipos que quieren un **base reutilizable** (sin cámara/ML u otros extras de producto).

**Convenciones cerradas (Fase 0):** [CONVENCIONES.md](./CONVENCIONES.md).

---

## Fase 0 — Acuerdos de equipo

- [ ] Convención de nombres de features (`snake_case`) y de clases públicas (`PascalCase`).
- [ ] Sufijos para DTOs (`*Dto` / `*Request` / `*Response`) si usarás `json_serializable`.
- [ ] ¿Siempre hay carpeta `domain/` o solo cuando el feature tiene reglas de negocio claras?
- [ ] Router **central** (`core/router`) que importa páginas desde `features/` (sin “auto-registro” mágico al inicio).

---

## Fase 1 — Dependencias

- [ ] Añadir `go_router` y `dio` en `dependencies`.
- [ ] Mantener `equatable` para estados/eventos de Bloc con varios campos.
- [ ] Si habrá API con JSON: `json_annotation` + `json_serializable` + `build_runner` (en `dev_dependencies`).
- [ ] `flutter pub get` sin conflictos.
- [ ] `flutter analyze` en verde (o lista de issues aceptados documentada).

---

## Fase 2 — `core/` transversal

- [ ] `lib/core/config/` — modelo de configuración por flavor (`apiBaseUrl`, flags de logging, etc.).
- [ ] `lib/core/network/` — fábrica de `Dio` leyendo la config (timeouts, `baseUrl`).
- [ ] `lib/core/network/interceptors/` — p. ej. log solo en dev/staging.
- [ ] `lib/core/router/app_routes.dart` — paths y nombres de ruta estables (deep links después).
- [ ] `lib/core/router/app_router.dart` — `GoRouter` y rutas iniciales.

---

## Fase 3 — Flavors ↔ config

- [ ] Cada `main_development.dart` / `main_staging.dart` / `main_production.dart` construye la `AppConfig` correcta.
- [ ] La config llega al árbol de widgets (holder/`InheritedWidget`/otro patrón acordado) **antes** de usar `Dio`/`GoRouter` si lo necesitan.

---

## Fase 4 — `App` con router

- [ ] Sustituir `MaterialApp` + `home:` por `MaterialApp.router` enlazado a `GoRouter`.
- [ ] Ruta inicial (home) y, si aplica, página 404.
- [ ] Probar los tres flavors:
  - [ ] `flutter run --flavor development --target lib/main_development.dart`
  - [ ] `flutter run --flavor staging --target lib/main_staging.dart`
  - [ ] `flutter run --flavor production --target lib/main_production.dart`

---

## Fase 5 — Estructura `features/` y demo

- [ ] Crear `lib/features/<nombre>/` con barrel `*.dart` que exporte página (y Bloc/Cubit si aplica).
- [ ] Registrar rutas en `app_router` apuntando a las páginas públicas del feature.
- [ ] Eliminar o mover el `counter` del template a `features/counter/` (o borrarlo) y actualizar tests/imports.
- [ ] `flutter test` pasa tras el cambio.

---

## Fase 6 — Bloc + Equatable en features

- [ ] Estados y eventos con `Equatable` donde haya varios campos.
- [ ] Presentation sin lógica de JSON ni de HTTP directo.

---

## Fase 7 — `json_serializable` (cuando exista API)

- [ ] DTOs solo en `features/.../data/models/` (+ `*.g.dart` vía `build_runner`).
- [ ] Repositorio mapea DTO → modelo/entidad que consume el Bloc.
- [ ] Documentar en README el comando habitual: `dart run build_runner build --delete-conflicting-outputs` (o `watch`).

---

## Fase 8 — Tests por feature (sin Mason)

- [ ] Por cada feature nuevo, crear bajo `test/` el espejo de carpetas que uses (como `test/counter/...`).
- [ ] Widget tests: extensión `pumpApp` en `test/helpers/pump_app.dart` y **import relativo** a `helpers` (el analizador no puede tratar plantillas Mason en el mismo repo sin errores).
- [ ] Cubit/Bloc tests: `bloc_test` como en `test/counter/cubit/counter_cubit_test.dart`.
- [ ] Si pasás a `MaterialApp.router`, valorar un `pumpRouterApp` en `test/helpers` y reutilizarlo en los widget tests.

**Nota:** Los helpers que usan `flutter_test` deben quedar en `test/`; no convierten bien a `package:...` bajo `lib/` por la restricción de `flutter_test`.

---

## Fase 9 — Deep links

- [ ] Paths estables en `app_routes` alineados con lo que declararás en plataforma.
- [ ] Android: intent filters por flavor si aplica.
- [ ] iOS: Associated Domains / URL types según entorno.
- [ ] Prueba manual con enlaces reales.

---

## Fase 10 — Base reutilizable y CI

- [ ] README del repo: qué **incluye** y qué **excluye** el base (sin cámara/ML; paquetes en `packages/` aparte).
- [ ] CI existente: `analyze` + `test` (y cobertura si usás `very_good test`).
- [ ] (Opcional) Carpeta `packages/` con README o `.gitkeep` para futuros paquetes internos.

---

## Comandos útiles (referencia rápida)

| Acción | Comando |
|--------|---------|
| Dependencias | `flutter pub get` |
| Análisis | `flutter analyze` |
| Tests | `flutter test` |
| Tests + cobertura (Very Good) | `very_good test --coverage --test-randomize-ordering-seed random` |
| Codegen JSON | `dart run build_runner build --delete-conflicting-outputs` |

---

## Dependencia entre fases

Hasta la **Fase 5** deberías tener una app **navegable por flavor**. **Fase 7** solo cuando haya contrato JSON real. **Fase 8** conviene **después** de estabilizar el router y el helper de tests (`pumpApp` o `pumpRouterApp`).

### Mason (opcional, más adelante)

Si más adelante querés bricks, conviene un **repo o carpeta aparte** (o ignorar `__brick__` en el análisis), porque los archivos con `{{ mustache }}` **no son Dart válido** y el IDE marcará errores si viven dentro del mismo proyecto que analizás como app.
