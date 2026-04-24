# Convenciones del proyecto

Documento vivo: refleja los acuerdos de **Fase 0** y guía implementación en `lib/`.

---

## 1. Features y nombres públicos

- **Carpetas de feature** bajo `lib/features/`: **`snake_case`** (ej. `user_profile`, `order_detail`).
- **Tipos y clases expuestos** (páginas, cubits, blocs, entidades públicas del feature): **`PascalCase`** (ej. `UserProfilePage`, `OrderDetailCubit`).
- **Barrel del feature:** `lib/features/<nombre>/<nombre>.dart` exporta lo que otros módulos o el router deben importar.

---

## 2. Modelos de red y `json_serializable`

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

## 3. Dominio (`domain/`)

- Se usa **`domain/` en cada feature** (o al menos siempre que el feature tenga datos que no deben filtrarse tal cual desde la capa `data/`).
- **Responsabilidad:** entidades y reglas que la **UI y el Bloc** consumen **después** de mapear lo que viene del API (o de otras fuentes). Lo que “luce como el JSON del servidor” permanece en **`data/`** (DTOs / Request / Response).
- **Flujo esperado:** `data` (contrato red) → mapeo → `domain` (modelo estable) → `bloc` / `presentation`.

Si un feature es trivial (sin red y un solo modelo), igual podés mantener una carpeta `domain/` mínima para no romper el patrón del repo.

---

## 4. Router

- **Un solo lugar** para la configuración de rutas: `lib/core/router/` (p. ej. `app_routes.dart`, `app_router.dart`).
- Las **páginas** viven en `features/`; el router **importa** esas pantallas (o barrels) y **registra** cada ruta **explícitamente**. Sin auto-descubrimiento ni reflexión de rutas.
- Deep links y nombres de ruta estables se documentan junto a `app_routes`.

---

## 5. Tests

- Espejo de carpetas bajo `test/features/...` cuando existan features allí.
- Helpers con `flutter_test` en `test/helpers/`; imports relativos desde cada test (ver checklist de implementación).

---

## Referencias

- Progreso de implementación: [CHECKLIST_IMPLEMENTACION.md](./CHECKLIST_IMPLEMENTACION.md).
