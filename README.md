# Ejemplo Flutter Very Good

![cobertura][coverage_badge]
[![estilo: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![licencia: MIT][license_badge]][license_link]

Generado con [Very Good CLI][very_good_cli_link] 🤖

Ejemplo de proyecto Very Good CLI.

---

## Arquitectura del proyecto

El código bajo `lib/` sigue un mapa **por capas y por feature**:

| Carpeta | Rol |
|--------|-----|
| **`lib/app/`** | Raíz de la app: `App` (tema, `MaterialApp.router`, `RepositoryProvider` del ejemplo), delegados de localización. |
| **`lib/core/`** | Transversal: `AppConfig` y flavors, cliente `Dio`, `createDio`, router (`createAppRouter`, rutas, páginas de error), `AppGlobalBlocProviders`, widgets/presentación compartida. |
| **`lib/features/<feature>/`** | Cada feature aislado: **presentación** (páginas y widgets) → **cubit** (estado) → **dominio** (contratos y modelos) → **datos** (API, DTOs, interceptors, repositorio simulado). |

El feature de referencia es **`lib/features/example/`**: ahí está documentada la estructura de carpetas, el flujo de datos y las convenciones (barrel `example.dart`, dónde va el `BlocProvider`, etc.). Úsala como guía al crear features nuevos o al usar el brick (Mason).

**Tests:** bajo `test/` se repite la misma forma por feature (`cubit`, `data`, `presentation`…), más tests de `app/`, `core/router`, `core/network`, etc. El CI exige **cobertura de líneas sobre `lib/`** (ver workflow).

---

## Pull requests: qué tener en cuenta

### Título del PR (Conventional Commits)

El job **`semantic-pull-request`** (`.github/workflows/main.yaml`) valida el **título del pull request** con el estilo [Conventional Commits](https://www.conventionalcommits.org/) (por ejemplo `feat: …`, `fix: …`, `chore: …`, `docs: …`). Si el título no cumple, el check falla aunque el código esté bien.

### Lo que corre el CI al abrir/actualizar un PR a `main`

| Job | Qué hace (resumen) |
|-----|---------------------|
| **build** (`flutter_package`) | Formato (`dart format` con comprobación), `flutter analyze` sobre `lib` y `test`, **bloc lint** (`bloc lint .`), y **`very_good test`** con cobertura, reporte en `lib` y umbral mínimo de cobertura. No es solo “un comando”: equivale a que el código esté formateado, analizado, alineado con reglas de Bloc y con los tests y cobertura al nivel que define Very Good. |
| **spell-check** | Ortografía (CSpell) en archivos `**/*.md` según `.github/cspell.json`. |
| **license_check** (workflow aparte) | Solo se dispara si cambiás `pubspec.yaml` o el propio flujo: revisa que las **licencias de dependencias** estén en la lista permitida. |

**Consejos antes de pedir review**

- Corré `dart format lib test` y asegurate de que `flutter test` o `very_good test` (con las mismas ideas que en CI) pasen en local.  
- Si editás documentación, revisá que CSpell no marque palabras válidas; si hace falta, añadilas a `.github/cspell.json`.  
- Los PRs al mismo branch cancelan el workflow anterior (`concurrency`) para ahorrar minutos de runner.

---

## Mason: plantillas de código (`feature_counter_base`)

[Mason](https://pub.dev/packages/mason) permite generar archivos a partir de **bricks** (plantillas). En este repo el registro está en `mason.yaml` y apunta al brick local **`bricks/feature_counter_base`**: genera un feature con la misma idea de capas que `example` (cubit, dominio, datos con Dio + DTO, interceptor mock, presentación, esqueleto de tests).

### Requisito

- [Mason CLI](https://pub.dev/packages/mason_cli): `dart pub global activate mason_cli`

### Uso (desde la raíz del proyecto)

```sh
mason get
mason make feature_counter_base
```

El asistente pide, entre otros:

- **Nombre del feature** en `snake_case` (por ejemplo `invoice`).  
- **Nombre del paquete** según el `name` de `pubspec.yaml` (por defecto `flutter_very_good_example`).

### Después de generar (checklist resumida)

1. **Generar código** del DTO: `dart run build_runner build --delete-conflicting-outputs`.  
2. **Registrar** la implementación del repositorio en el árbol (como hace `App` con `ExampleRepository`).  
3. Añadir **ruta** en `app_router.dart` / `app_routes.dart` si la pantalla se navega desde el router.  
4. Sustituir textos en inglés hardcodeados por **l10n** (`AppLocalizations` + ARB) cuando toque.  
5. Completar los **tests** bajo `test/features/<feature>/` (el brick deja estructura/esqueleto).

Detalle extra: `bricks/feature_counter_base/README.md`.

---

## Cómo ejecutar la app

Este proyecto define **tres flavors** (sabores de build):

- `development`
- `staging`
- `production`

Podés arrancar el flavor deseado con la **configuración de ejecución** en VS Code / Android Studio, o con estos comandos:

```sh
# Desarrollo
$ flutter run --flavor development --target lib/main_development.dart

# Staging (preproducción)
$ flutter run --flavor staging --target lib/main_staging.dart

# Producción
$ flutter run --flavor production --target lib/main_production.dart
```

_\*La app compila y corre en iOS, Android, Web y Windows._

---

## Tests

Para ejecutar tests unitarios y de widget (con el mismo enfoque que en CI, incluida cobertura en `lib/`), usá:

```sh
$ very_good test --coverage --test-randomize-ordering-seed random
```

Para generar y abrir un **informe HTML de cobertura** hace falta [lcov](https://github.com/linux-test-project/lcov) (p. ej. en macOS: `brew install lcov`):

```sh
# Generar el informe HTML
$ genhtml coverage/lcov.info -o coverage/

# Abrir el informe (macOS)
$ open coverage/index.html
```

---

## Bloc lints

El proyecto usa [bloc_lint](https://pub.dev/packages/bloc_lint) para alinear el código con buenas prácticas de [bloc](https://pub.dev/packages/bloc).

Validación manual desde la raíz del proyecto:

```bash
dart run bloc_tools:bloc lint .
```

En **VS Code** (u otros editores compatibles) podés instalar la [extensión oficial de Bloc](https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc) para avisos en el editor.

Más información: <https://bloclibrary.dev/lint/>

---

## Traducciones (i18n)

Se sigue la [guía oficial de internacionalización de Flutter][internationalization_link] y se usan [archivos ARB][arb_documentation_link] como fuente de cadenas.

### Añadir cadenas nuevas

1. Abrí `lib/localization/arb/app_en.arb` y agregá la clave, el valor y (opcional) la descripción con prefijo `@`:

```arb
{
    "@@locale": "en",
    "exampleAppBarTitle": "Example",
    "@exampleAppBarTitle": {
        "description": "Texto en el AppBar de la página de ejemplo"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Saludo de ejemplo"
    }
}
```

2. Usá la clave en la UI a través de `context.localization` (o el API generado equivalente):

```dart
import 'package:flutter_very_good_example/localization/localization.dart';

@override
Widget build(BuildContext context) {
  final localization = context.localization;
  return Text(localization.helloWorld);
}
```

### Idiomas soportados en iOS

Incluí el identificador del idioma en el array `CFBundleLocalizations` de `ios/Runner/Info.plist` cuando agregues un locale nuevo.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Archivos ARB por idioma

1. En `lib/localization/arb/`, añadí un `.arb` por locale (nombres de ejemplo):

```
├── localization
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Completá las traducciones en cada archivo, por ejemplo en `app_es.arb`:

```arb
{
    "@@locale": "es",
    "exampleAppBarTitle": "Ejemplo",
    "@exampleAppBarTitle": {
        "description": "Texto mostrado en el AppBar de la página de ejemplo"
    },
    "helloWorld": "Hola Mundo",
    "@helloWorld": {
        "description": "Saludo de ejemplo en español."
    }
}
```

### Regenerar código de localización

Tras modificar ARB, generá las clases de `AppLocalizations`:

```sh
flutter gen-l10n --arb-dir="lib/localization/arb"
```

También podés correr `flutter run`: el codegen se dispara al compilar.

[coverage_badge]: coverage_badge.svg
[internationalization_link]: https://docs.flutter.dev/ui/internationalization
[arb_documentation_link]: https://github.com/google/app-resource-bundle
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
