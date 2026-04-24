# Checklist de implementación — base Very Good + router + red

Marca cada ítem al completarlo. Pensado para el repo `flutter_very_good_example` y equipos que quieren un **base reutilizable** (sin cámara/ML u otros extras de producto).

**Convenciones:** [CONVENCIONES.md](./CONVENCIONES.md) (estructura `features/`, `core/presentation`, DTOs, dominio, router).

---

## Resumen del estado actual (rápido)

| Área | Estado |
|------|--------|
| Flavors + `AppConfig` + `main_*` | Hecho |
| Dio + interceptor + `createDio` | Hecho |
| GoRouter: splash → home → example; rutas `/error`, `/access-denied`; `errorBuilder` → `NotFoundPage` | Hecho |
| Features: `splash`, `home`, `example` bajo `presentation/pages/` | Hecho |
| Tema (`app_colors`, `app_theme`) | Hecho |
| `AppGlobalBlocProviders` (lista vacía hasta primer Bloc global) | Hecho |
| `core/presentation` (`AppLoadingIndicator`, responsive `app_breakpoints.dart`) | Hecho |
| Localización (`l10n.yaml`, `localization/arb/`, `gen/`, delegados en `App`) | Hecho |
| Inyección: `RepositoryProvider<ExampleRepository>`; `Dio` creado en `App` y pasado al repo (no expuesto como `Provider<Dio>`) | Hecho |
| Feature **example**: `domain/`, `data/` (API + interceptor mock), `json_serializable` en respuesta | Hecho |
| README: arquitectura, PR/CI, Mason + codegen, alcance del ejemplo | Hecho |
| Deep links en stores | Pendiente |

---

## Fase 0 — Acuerdos de equipo

- [x] Convención de nombres de features (`snake_case`) y de clases públicas (`PascalCase`).  
      **Hecho:** `docs/CONVENCIONES.md`; features en `lib/features/`.
- [x] Sufijos para DTOs (`*Dto` / `*Request` / `*Response`) si usarás `json_serializable`.  
      **Hecho:** documentado en CONVENCIONES (modelos de red).
- [x] Política de `domain/` por feature.  
      **Hecho:** CONVENCIONES (dominio); en código, **example** tiene `domain/` y `data/` como referencia (repositorio + snapshot + API).
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
- [x] `lib/core/router/app_routes.dart` — `AppRoute` con `path` + `name` (`splash`, `home`, `example`, `error`, `access_denied`).
- [x] `lib/core/router/app_router.dart` — `GoRouter`; entrada en splash; `debugLogDiagnostics` en development.
- [x] `lib/core/router/pages/` — páginas transversales: `not_found_page.dart` (404 vía `errorBuilder`), `error_page.dart`, `access_denied_page.dart`.

---

## Fase 2bis — App shell (tema, providers, UI compartida)

- [x] `lib/app/theme/` — `app_colors.dart`, `app_theme.dart` (Material 3, widgets base).
- [x] `lib/app/view/app.dart` — `MaterialApp.router`, `AppTheme.light()`, delegados y `supportedLocales` de gen-l10n.
- [x] `lib/core/bloc/app_global_bloc_providers.dart` — listo para `MultiBlocProvider` (vacío = sin envolver).
- [x] `lib/core/presentation/` — widgets reutilizables (`AppLoadingIndicator`); **responsive** en `responsive/app_breakpoints.dart` (`AppBreakpoint`, `responsiveValue`, `ResponsiveLayout`); barrel `presentation.dart`.
- [x] Localización — `l10n.yaml`; ARB en `lib/localization/arb/`; salida generada en `lib/localization/gen/` (`flutter gen-l10n` vía `flutter pub get` / build).

---

## Fase 3 — Flavors ↔ config

- [x] Cada `main_*` pasa la `AppConfig` correcta al `App`.
- [x] Repositorios en el árbol cuando aplica la capa de datos.  
      **Hoy:** `RepositoryProvider<ExampleRepository>` en `App` con `ApiExampleRepository(dio: _dio)`; `Dio` no se expone solo (aceptable hasta que otro feature lo necesite compartido).

---

## Fase 4 — Router y validación manual

- [x] `MaterialApp.router` + `GoRouter`.
- [x] Flujo: **splash** (`/splash`) → **home** (`/`) → **example** (`/example` con `push`).
- [x] Ruta inexistente → `errorBuilder` muestra `NotFoundPage` (404). Rutas declaradas: `/error` (`ErrorPage`, query `message`), `/access-denied` (`AccessDeniedPage`).
- [ ] Probar los tres flavors en dispositivo/emulador:
  - [ ] `flutter run --flavor development --target lib/main_development.dart`
  - [ ] `flutter run --flavor staging --target lib/main_staging.dart`
  - [ ] `flutter run --flavor production --target lib/main_production.dart`

---

## Fase 5 — Estructura `features/`

- [x] Features con barrel `features/<nombre>/<nombre>.dart`.
- [x] Pantallas en `presentation/pages/`; **example** con `cubit/`, `domain/`, `data/`; **splash** y **home** solo presentación.
- [x] Rutas registradas en `app_router.dart`.
- [x] Tests bajo `test/features/...` espejando la estructura (presentación, cubit, datos/interceptors donde aplica); `flutter test` OK.

---

## Fase 6 — Bloc + Equatable en features

- [x] Estados con `Equatable` cuando el estado tiene varios campos — **ExampleCubitState** (`Equatable` + `props`).
- [x] Presentación sin llamadas HTTP ni JSON directo en widgets (orquestación vía Cubit y repositorio inyectado).

---

## Fase 7 — `json_serializable` (cuando exista API)

- [x] DTO de ejemplo en `features/example/data/models/` + `*.g.dart` (`ExampleAdjustResponse`, `build_runner`).
- [x] Repositorio: `ApiExampleRepository` parsea respuesta → `ExampleSnapshot` / dominio para el Cubit.
- [x] Documentar codegen JSON en README: sección [Mason: plantillas de código](../README.md#mason-plantillas-de-código-feature_counter_base) (paso `build_runner`); comando también en [Comandos útiles](#comandos-útiles) de este documento.

---

## Fase 8 — Tests

- [x] Espejo `test/features/<feature>/presentation/pages/` (y `cubit/` donde aplique).
- [x] `test/helpers/pump_app.dart` + barrel `helpers.dart` + imports relativos a `helpers`.
- [x] Tests de Cubit con `bloc_test` (`test/features/example/cubit/...`).
- [x] Tests de navegación con `GoRouter` en `test/core/router/app_router_test.dart` (no hace falta un helper con nombre fijo; opcional: extraer un `pumpRouterApp` a `test/helpers` si se repite mucho).

**Nota:** helpers con `flutter_test` solo en `test/` (no bajo `lib/`).

---

## Fase 9 — Deep links

- [x] Paths y `name` estables en `AppRoutes` (base para universal links).
- [ ] Android: intent filters / App Links por flavor si aplica.
- [ ] iOS: Associated Domains / URL types por entorno.
- [ ] Prueba manual con enlaces reales.

---

## Fase 10 — Base reutilizable y CI

- [x] README en la raíz: [arquitectura](../README.md#arquitectura-del-proyecto), [PR y CI](../README.md#pull-requests-qué-tener-en-cuenta), [alcance del repositorio](../README.md#alcance-de-este-repositorio), [Mason + `build_runner`](../README.md#mason-plantillas-de-código-feature_counter_base).
- [x] CI: `.github/workflows/main.yaml` — `semantic-pull-request`, `build` (Very Good `flutter_package` con `run_bloc_lint: true`, formato, análisis, tests con cobertura), `spell-check` sobre `**/*.md` (CSpell vía [`.github/cspell.json`](../.github/cspell.json), inglés + español y palabras de proyecto). Workflow aparte `license_check.yaml` si cambia `pubspec.yaml` o el flujo.
- [ ] (Opcional) Carpeta `packages/` y documentación de módulos internos si el monorepo crece.

---

## Comandos útiles

| Acción | Comando |
|--------|---------|
| Dependencias | `flutter pub get` |
| Análisis | `flutter analyze` |
| Tests | `flutter test` |
| Tests + cobertura (Very Good) | `very_good test --coverage --test-randomize-ordering-seed random` (en CI, cobertura sobre `lib/` con umbral mínimo) |
| Codegen JSON | `dart run build_runner build --delete-conflicting-outputs` (o `watch` en local) |
| Informe HTML de cobertura (local) | `genhtml coverage/lcov.info` → ver [README, sección Tests](../README.md#tests) |

---

## Dependencia entre fases

**Fase 7** (ampliar DTOs; el codegen y el README/Mason ya están alineados) a medida que crezca la API. **Fase 3** (inyección) ya aplicada al **example**; repetir patrón para nuevos repos. **Fase 9** cuando el producto requiera enlaces externos.

### Mason (opcional)

- [x] Brick local **`feature_counter_base`** en `bricks/feature_counter_base/` (patrón **example** del repo: `lib` completo + tests esqueleto). Registro en `mason.yaml`.
- [x] Analyzer: `bricks/**/__brick__/**` excluido en `analysis_options.yaml`.
- Uso: instalar CLI (`dart pub global activate mason_cli`), luego en la raíz del repo: `mason get` → `mason make feature_counter_base`. Detalle en `bricks/feature_counter_base/README.md`.

Bricks adicionales con plantillas `{{ mustache }}` pueden vivir en **repo aparte** o bajo `bricks/`, manteniendo `__brick__` excluido del analyzer.
