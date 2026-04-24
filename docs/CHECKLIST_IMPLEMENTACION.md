# Checklist de implementación — base Very Good + router + red

Marca cada ítem al completarlo. Pensado para el repo `flutter_very_good_example` y equipos que quieren un **base reutilizable** (sin cámara/ML u otros extras de producto).

**Convenciones:** [CONVENCIONES.md](./CONVENCIONES.md) (estructura `features/`, `core/presentation`, DTOs, dominio, router).

---

## Resumen del estado actual (rápido)

| Área | Estado |
|------|--------|
| Flavors + `AppConfig` + `main_*` | Hecho |
| Dio + interceptor + `createDio` | Hecho |
| GoRouter: splash → home → counter (`/counter`) | Hecho |
| Features: `splash`, `home`, `counter` bajo `presentation/pages/` | Hecho |
| Tema (`app_colors`, `app_theme`) | Hecho |
| `AppGlobalBlocProviders` (lista vacía hasta primer Bloc global) | Hecho |
| `core/presentation` (`AppLoadingIndicator`, …) | Iniciado |
| Inyección `Dio`/repos en el árbol | Pendiente |
| `domain/` / `data/` + API real | Pendiente |
| Deep links en stores | Pendiente |

---

## Fase 0 — Acuerdos de equipo

- [x] Convención de nombres de features (`snake_case`) y de clases públicas (`PascalCase`).  
      **Hecho:** `docs/CONVENCIONES.md`; features en `lib/features/`.
- [x] Sufijos para DTOs (`*Dto` / `*Request` / `*Response`) si usarás `json_serializable`.  
      **Hecho:** documentado en CONVENCIONES (modelos de red).
- [x] Política de `domain/` por feature.  
      **Hecho:** CONVENCIONES (dominio); en código aún **no** hay carpetas `domain/` hasta el primer feature con API/reglas.
- [x] Router central en `core/router` con registro explícito de rutas.  
      **Hecho:** `app_routes.dart` + `app_router.dart` importan páginas desde `features/`.

---

## Fase 1 — Dependencias

- [x] `go_router` y `dio` en `dependencies`.
- [x] `equatable` para estados/eventos de Bloc con varios campos.
- [x] `json_annotation` + `json_serializable` + `build_runner` (cuando uses API con JSON).
- [x] `flutter pub get` sin conflictos.
- [x] `flutter analyze` en verde.

---

## Fase 2 — `core/` transversal (red y rutas)

- [x] `lib/core/config/` — `AppConfig`, `AppFlavor`, `API_BASE_URL` vía `fromEnvironment`.
- [x] `lib/core/network/` — `createDio(AppConfig)`.
- [x] `lib/core/network/interceptors/` — `DioLoggerInterceptor` si `enableNetworkLogging`.
- [x] `lib/core/router/app_routes.dart` — `AppRoute` con `path` + `name` (`splash`, `home`, `counter`).
- [x] `lib/core/router/app_router.dart` — `GoRouter`; entrada en splash; `debugLogDiagnostics` en development.

---

## Fase 2bis — App shell (tema, providers, UI compartida)

- [x] `lib/app/theme/` — `app_colors.dart`, `app_theme.dart` (Material 3, widgets base).
- [x] `lib/app/view/app.dart` — `MaterialApp.router`, `AppTheme.light()`.
- [x] `lib/core/bloc/app_global_bloc_providers.dart` — listo para `MultiBlocProvider` (vacío = sin envolver).
- [x] `lib/core/presentation/` — widgets reutilizables entre features (p. ej. `AppLoadingIndicator`); barrel `presentation.dart`.

---

## Fase 3 — Flavors ↔ config

- [x] Cada `main_*` pasa la `AppConfig` correcta al `App`.
- [ ] Exponer `Dio` y/o repositorios en el árbol (`Provider`, `RepositoryProvider`, `InheritedWidget`, etc.) cuando exista capa de datos.  
      **Hoy:** solo `createDio`; ningún widget consume un cliente inyectado.

---

## Fase 4 — Router y validación manual

- [x] `MaterialApp.router` + `GoRouter`.
- [x] Flujo: **splash** (`/splash`) → **home** (`/`) → **counter** (`/counter` con `push`).
- [ ] Página **404** / `errorBuilder` en `GoRouter` (opcional).
- [ ] Probar los tres flavors en dispositivo/emulador:
  - [ ] `flutter run --flavor development --target lib/main_development.dart`
  - [ ] `flutter run --flavor staging --target lib/main_staging.dart`
  - [ ] `flutter run --flavor production --target lib/main_production.dart`

---

## Fase 5 — Estructura `features/`

- [x] Features con barrel `features/<nombre>/<nombre>.dart`.
- [x] Pantallas en `presentation/pages/`; **counter** con `cubit/`; **splash** y **home** solo presentación.
- [x] Rutas registradas en `app_router.dart`.
- [x] Tests bajo `test/features/...` espejando la estructura; `flutter test` OK.

---

## Fase 6 — Bloc + Equatable en features

- [ ] Estados y eventos con `Equatable` cuando dejen de ser tipos primitivos (el **CounterCubit** usa `int`; no aplica aún).
- [x] Presentación sin llamadas HTTP ni JSON directo en widgets (solo navegación y Cubit local en counter).

---

## Fase 7 — `json_serializable` (cuando exista API)

- [ ] DTOs en `features/.../data/models/` + `*.g.dart` (`build_runner`).
- [ ] Repositorio: mapeo DTO → modelo de dominio / entidad para el Bloc.
- [ ] Documentar en README: `dart run build_runner build --delete-conflicting-outputs` (o `watch`).

---

## Fase 8 — Tests

- [x] Espejo `test/features/<feature>/presentation/pages/` (y `cubit/` donde aplique).
- [x] `test/helpers/pump_app.dart` + imports relativos a `helpers`.
- [x] Tests de Cubit con `bloc_test` (`test/features/counter/cubit/...`).
- [ ] (Opcional) `pumpRouterApp` o helper que monte `MaterialApp.router` + rutas para tests de integración de navegación.

**Nota:** helpers con `flutter_test` solo en `test/` (no bajo `lib/`).

---

## Fase 9 — Deep links

- [x] Paths y `name` estables en `AppRoutes` (base para universal links).
- [ ] Android: intent filters / App Links por flavor si aplica.
- [ ] iOS: Associated Domains / URL types por entorno.
- [ ] Prueba manual con enlaces reales.

---

## Fase 10 — Base reutilizable y CI

- [ ] README: qué **incluye** y **excluye** el base (sin cámara/ML; paquetes en `packages/` aparte).
- [ ] Confirmar CI: `analyze` + `test` (y `very_good test --coverage` si lo usás).
- [ ] (Opcional) `packages/` con nota para paquetes internos.

---

## Comandos útiles

| Acción | Comando |
|--------|---------|
| Dependencias | `flutter pub get` |
| Análisis | `flutter analyze` |
| Tests | `flutter test` |
| Tests + cobertura (Very Good) | `very_good test --coverage --test-randomize-ordering-seed random` |
| Codegen JSON | `dart run build_runner build --delete-conflicting-outputs` |

---

## Dependencia entre fases

**Fase 7** cuando haya contrato HTTP real. **Fase 3** (inyección) conviene al mismo tiempo que el primer repositorio. **Fase 9** cuando el producto requiera enlaces externos.

### Mason (opcional)

Bricks con plantillas `{{ mustache }}` mejor en **repo aparte** o carpeta excluida del análisis, para no romper el analyzer del app.
