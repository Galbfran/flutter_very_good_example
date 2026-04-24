# Feature: counter

Ejemplo de feature con capas **presentación → cubit → dominio → datos**, y cliente HTTP (`Dio`) con contrato estable para poder sustituir la implementación sin tocar la UI.

## Estructura de carpetas

```text
counter/
├── counter.dart              # Barrel: exporta lo público del feature
├── cubit/                    # Estado y orquestación
├── domain/                   # Contratos y modelos de negocio
├── data/                     # Implementaciones (API, mocks, DTOs)
└── presentation/
    ├── pages/                # Pantalla enrutada (BlocProvider)
    └── widgets/              # UI descompuesta (scaffold, body, listeners…)
```

## Capas y responsabilidades

### Presentación (`presentation/`)

- **`pages/counter_page.dart`** — Crea el `BlocProvider<CounterCubit>` y resuelve `CounterRepository` del árbol (`RepositoryProvider` en `App`).
- **`widgets/`** — Composición visual: scaffold fuera de los builders reactivos, cuerpo con `BlocBuilder`, FABs con `BlocSelector`, efectos laterales con `BlocListener` agrupados en `counter_view_listeners.dart`.

La presentación **no** importa `Dio` ni modelos JSON; solo el cubit, el dominio (tipos que expone el estado) y `localization`.

### Cubit (`cubit/`)

- **`counter_cubit.dart`** — Llama al repositorio en `increment` / `decrement`, maneja loading / success / failure.
- **`counter_state.dart`** — `CounterCubitState`: `status`, `CounterSnapshot`, `errorMessage`.

Depende únicamente de la **interfaz** `CounterRepository` (dominio).

### Dominio (`domain/`)

- **`counter_snapshot.dart`** — Valor que entiende la app: `current` y `previous`.
- **`counter_repository.dart`** — Contrato abstracto (`increment` / `decrement`).

Aquí no hay Flutter de UI ni serialización HTTP: es la frontera estable del feature.

### Datos (`data/`)

- **`api_counter_repository.dart`** — Implementación con `Dio`: `POST /counter/adjust`, body y parseo de respuesta.
- **`models/counter_adjust_response.dart`** — DTO de respuesta JSON (`json_serializable`, solo `fromJson`).
- **`interceptors/counter_mock_interceptor.dart`** — Interceptor que responde como el backend **sin red real** (útil hasta tener API). Cuando exista servidor, se puede quitar si el contrato coincide.
- **`simulated_counter_repository.dart`** — Alternativa sin `Dio` (delay en memoria); útil en tests o prototipos.

## Flujo de datos

1. El usuario dispara una acción en un widget → `CounterCubit.increment()` (o `decrement`).
2. El cubit emite `loading` y llama `await repository.increment(snapshot)`.
3. El repositorio concreto (`ApiCounterRepository`) usa `Dio`; el mock interceptor o el backend devuelven JSON.
4. Se mapea la respuesta a `CounterSnapshot` y el cubit emite `success` (o `failure` si hay error).

## Composición fuera del feature

En `App` se construye `Dio` (`createDio`) con interceptors opcionales y se registra:

`RepositoryProvider<CounterRepository>(create: (_) => ApiCounterRepository(dio: …))`.

El barrel `counter.dart` exporta dominio, cubit, página y vista; **no** exporta la implementación en `data/` para no acoplar otras partes al HTTP concreto.

## Tests (referencia)

| Capa        | Enfoque típico |
|------------|----------------|
| Cubit      | `bloc_test` + implementación fake de `CounterRepository` |
| `ApiCounterRepository` | `Dio` + `CounterMockInterceptor` con delay cero |
| Widgets    | `MockCubit<CounterCubitState>` + `BlocProvider.value` |

Los tests viven en `test/features/counter/`, espejando esta estructura.

## Documentación del proyecto

Convenciones generales: `docs/CONVENCIONES.md` y `docs/CHECKLIST_IMPLEMENTACION.md`.
