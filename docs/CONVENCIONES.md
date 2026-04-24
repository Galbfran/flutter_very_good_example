# Convenciones del proyecto

Documento vivo: refleja los acuerdos de **Fase 0** y guía implementación en `lib/`.

---

## 1. Features y nombres públicos

- **Carpetas de feature** bajo `lib/features/`: **`snake_case`** (ej. `user_profile`, `order_detail`).
- **Tipos y clases expuestos** (páginas, cubits, blocs, entidades públicas del feature): **`PascalCase`** (ej. `UserProfilePage`, `OrderDetailCubit`).
- **Barrel del feature:** `lib/features/<nombre>/<nombre>.dart` exporta lo que otros módulos o el router deben importar.

### Estructura interna (carpetas)

- **`presentation/pages/`** — pantallas enrutadas (`*_page.dart`). Opcional: `presentation/widgets/` para piezas solo de ese feature.
- **`bloc/`** o **`cubit/`** — estado del feature (omitir si la pantalla es solo UI).
- **`data/`**, **`domain/`** — cuando haya red o reglas de negocio (ver secciones siguientes).

Dentro del feature, los imports entre capas del mismo módulo pueden ser **relativos**; hacia fuera del feature, **`package:flutter_very_good_example/...`**.

---

## 2. Presentación compartida (`lib/core/presentation/`)

- **Widgets y patrones UI reutilizables** entre varios features: loaders, diálogos genéricos, barras de error, etc.
- Ubicación: `lib/core/presentation/widgets/` (un archivo por widget o grupo pequeño). Barrel: `presentation.dart`.
- **No** mezclar aquí lógica de negocio ni acceso a repositorios: solo composición visual y `Theme.of` / callbacks.
- Si un componente es **específico de un flujo de producto**, vivirá en el **`feature`** correspondiente para no inflar `core`.

---

## 3. Modelos de red y `json_serializable`

Los tipos que reflejan **contrato con el backend** viven en `features/<nombre>/data/models/` (o la ruta equivalente acordada) y usan codegen cuando aplique.

| Dirección | Sufijo recomendado | Notas |
|-----------|-------------------|--------|
| **Del API hacia la app** (lectura, respuesta) | `*Response` | Ej. `UserResponse`, `OrderListResponse`. Si querés remarcar que es DTO de serialización: `*ResponseDto`. |
| **De la app hacia el API** (body de alta/actualización, acciones) | `*Request` | Ej. `LoginRequest`, `CreateOrderRequest`. Es más explícito que un `*Dto` genérico para “envío”. |
| **Neutro / compartido** | `*Dto` | Solo cuando **no** encaja en un par claro request/response de un endpoint (tipos reutilizados, caches, integraciones donde el nombre Request/Response confunde). |

**Sobre Request vs Dto:** no es obligatorio duplicar conceptos. Regla práctica:

- Para **enviar** datos a un endpoint → preferir **`*Request`**.
- Para **recibir** datos → preferir **`*Response`** (o `*ResponseDto` si el equipo quiere unificar el sufijo “Dto” solo en respuestas).
- Reservar **`*Dto`** para casos que no son “este request / esta response de este método HTTP”.

Así **Request** no compite con un “Dto de envío”: el envío **es** un request con nombre de caso de uso.

---

## 4. Dominio (`domain/`)

- Se usa **`domain/` en cada feature** (o al menos siempre que el feature tenga datos que no deben filtrarse tal cual desde la capa `data/`).
- **Responsabilidad:** entidades y reglas que la **UI y el Bloc** consumen **después** de mapear lo que viene del API (o de otras fuentes). Lo que “luce como el JSON del servidor” permanece en **`data/`** (DTOs / Request / Response).
- **Flujo esperado:** `data` (contrato red) → mapeo → `domain` (modelo estable) → `bloc` / `presentation`.

Si un feature es trivial (sin red y un solo modelo), igual podés mantener una carpeta `domain/` mínima para no romper el patrón del repo.

---

## 5. Router

- **Un solo lugar** para la configuración de rutas: `lib/core/router/` (p. ej. `app_routes.dart`, `app_router.dart`).
- Las **páginas** viven en `features/`; el router **importa** esas pantallas (o barrels) y **registra** cada ruta **explícitamente**. Sin auto-descubrimiento ni reflexión de rutas.
- Deep links y nombres de ruta estables se documentan junto a `app_routes`.

---

## 6. Tests

- Espejo de carpetas bajo `test/features/...` cuando existan features allí, más `test/core/`, `test/app/`, etc. cuando corresponda.
- Helpers con `flutter_test` en `test/helpers/` (p. ej. `pump_app.dart` y el barrel `helpers.dart`); imports relativos desde cada test (ver [checklist de implementación](./CHECKLIST_IMPLEMENTACION.md)).
- En CI, **Very Good** corre `very_good test` con cobertura sobre `lib/` y umbral mínimo: conviene reproducirlo en local antes de abrir un PR.

---

## Referencias

- Progreso de implementación: [CHECKLIST_IMPLEMENTACION.md](./CHECKLIST_IMPLEMENTACION.md).
