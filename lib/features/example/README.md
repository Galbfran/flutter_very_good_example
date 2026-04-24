# Feature: example

Ejemplo de feature con capas **presentación → cubit → dominio → datos**, y cliente HTTP (`Dio`) con contrato estable para poder sustituir la implementación sin tocar la UI.

## Estructura de carpetas

```text
example/
├── example.dart              # Barrel: exporta lo público del feature
├── cubit/                    # Estado y orquestación
├── domain/                   # Contratos y modelos de negocio
├── data/                     # Implementaciones (API, mocks, DTOs)
└── presentation/
    ├── pages/                # Pantalla enrutada (BlocProvider)
    └── widgets/              # UI descompuesta (scaffold, body, listeners…)
```

## Capas y responsabilidades

### Presentación (`presentation/`)

- **`pages/example_page.dart`** — Crea el `BlocProvider<ExampleCubit>` y resuelve `ExampleRepository` del árbol (`RepositoryProvider` en `App`).
- **`widgets/`** — Composición visual: scaffold fuera de los builders reactivos, cuerpo con `BlocBuilder`, FABs con `BlocSelector`, efectos laterales con `BlocListener` agrupados en `example_view_listeners.dart`.

La presentación **no** importa `Dio` ni modelos JSON; solo el cubit, el dominio (tipos que expone el estado) y `localization`.

### Cubit (`cubit/`)

- **`example_cubit.dart`** — Llama al repositorio en `increment` / `decrement`, maneja loading / success / failure.
- **`example_state.dart`** — `ExampleCubitState`: `status`, `ExampleSnapshot`, `errorMessage`.

Depende únicamente de la **interfaz** `ExampleRepository` (dominio).

### Dominio (`domain/`)

- **`example_snapshot.dart`** — Valor que entiende la app: `current` y `previous`.
- **`example_repository.dart`** — Contrato abstracto (`increment` / `decrement`).

Aquí no hay Flutter de UI ni serialización HTTP: es la frontera estable del feature.

### Datos (`data/`)

- **`api_example_repository.dart`** — Implementación con `Dio`: `POST /example/adjust`, body y parseo de respuesta.
- **`models/example_adjust_response.dart`** — DTO de respuesta JSON (`json_serializable`, solo `fromJson`).
- **`interceptors/example_mock_interceptor.dart`** — Interceptor que responde como el backend **sin red real** (útil hasta tener API). Cuando exista servidor, se puede quitar si el contrato coincide.
- **`simulated_example_repository.dart`** — Alternativa sin `Dio` (delay en memoria); útil en tests o prototipos.

## Flujo de datos

1. El usuario dispara una acción en un widget → `ExampleCubit.increment()` (o `decrement`).
2. El cubit emite `loading` y llama `await repository.increment(snapshot)`.
3. El repositorio concreto (`ApiExampleRepository`) usa `Dio`; el mock interceptor o el backend devuelven JSON.
4. Se mapea la respuesta a `ExampleSnapshot` y el cubit emite `success` (o `failure` si hay error).

## Composición fuera del feature

En `App` se construye `Dio` (`createDio`) con interceptors opcionales y se registra:

`RepositoryProvider<ExampleRepository>(create: (_) => ApiExampleRepository(dio: …))`.

El barrel `example.dart` exporta dominio, cubit, página y vista; **no** exporta la implementación en `data/` para no acoplar otras partes al HTTP concreto.

## Tests

Estructura en `test/features/example/` (espejo del feature + `support/`):

```text
test/features/example/
├── support/
│   ├── example_mock_cubit.dart    # MockCubit<ExampleCubitState>
│   └── example_test_doubles.dart    # FakeExampleRepository, FailingExampleRepository
├── cubit/
├── domain/
├── data/
│   ├── api_example_repository_test.dart
│   └── interceptors/
└── presentation/
    ├── pages/
    └── widgets/
```

| Capa | Enfoque |
|------|---------|
| Dominio | Igualdad de `ExampleSnapshot` (u otras reglas futuras). |
| Cubit | `bloc_test` + doubles en `support/`. |
| Data / interceptor | `Dio` + `ExampleMockInterceptor` (delay cero) o cuerpo inválido. |
| Página | `RepositoryProvider` + repo simulado + `pumpApp`. |
| Widgets | `MockExampleCubit` + **`BlocProvider<ExampleCubit>.value`** (requerido para `BlocSelector` / `BlocListener`). |

## Documentación del proyecto

Convenciones generales: `docs/CONVENCIONES.md` y `docs/CHECKLIST_IMPLEMENTACION.md`.
