# Taller de Counter en Starknet

En este taller, aprenderás a crear un smart contract simple en Starknet, implementar funciones públicas, eventos y acceder a contratos externos.

Después de completar cada paso, ejecuta el script asociado para verificar que se haya implementado correctamente.

Utiliza el [Cairo book](https://book.cairo-lang.org/ch00-00-introduction.html) y la [Documentación de Starknet](https://docs.starknet.io/documentation/) como referencia.

## Configuración

1. Clona este repositorio.
2. Crea un nuevo archivo llamado `counter.cairo` dentro de la carpeta `src`.
3. Copia el siguiente código en el archivo.

```rust
#[starknet::contract]
mod Counter {
    #[storage]
    struct Storage {}
}
```

> **Nota:** Trabajarás en el archivo `counter.cairo` para completar los requisitos de cada paso. El archivo `prev_solution.cairo` aparecerá en pasos futuros como una forma de ponerte al día con el taller si te quedas atrás. **No modifiques ese archivo**.

Los siguientes pasos de configuración dependerán de si prefieres usar Docker para gestionar dependencias globales o no.

### Opción 1: Sin Docker

4. Instala Scarb 2.6.3 ([instrucciones](https://docs.swmansion.com/scarb/download.html#install-via-asdf)).
5. Instala Starknet Foundry 0.20.0 ([instrucciones](https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html)).
6. Instala la extensión Cairo 1.0 para VSCode ([marketplace](https://marketplace.visualstudio.com/items?itemName=starkware.cairo1)).
7. Ejecuta los tests para verificar que el proyecto esté configurado correctamente.

```
scarb test
```

### Opción 2: Con Docker

4. Asegúrate de que Docker esté instalado y en funcionamiento.
5. Instala la extensión Dev Containers para VSCode ([marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)).
6. Lanza una instancia de VSCode dentro del contenedor yendo a **Ver -> Paleta de comandos -> Dev Containers: Reconstruir y reabrir en contenedor**.
7. Abre el terminal integrado de VSCode y ejecuta los tests para verificar que el proyecto esté configurado correctamente.

```
scarb test
```

> **Nota:** Todos los comandos mostrados a partir de este punto asumirán que estás utilizando el terminal integrado de una instancia de VSCode ejecutándose dentro del contenedor. Si quieres ejecutar los tests en un terminal diferente, necesitarás usar el comando `docker compose run test`.

## Paso 1

Crea una rama `step1` para habilitar los tests de verificación para esta sección.

```bash
git checkout -b step1 origin/step1
```

O Simplemente cambia de rama a `step1` si ya la tienes creada.

```bash
git checkout step1
```

### Objetivo

En este paso, necesitarás hacer lo siguiente:

1. Almacenar una variable llamada `counter` como tipo `u32` en la estructura `Storage`.
2. Implementar la función del constructor que inicializa la variable `counter` con un valor de entrada dado.
3. Implementar una función pública llamada `get_counter()` que devuelva el valor de la variable `counter`.

### Requisitos

- La función `get_counter()` debe estar dentro de la interfaz del contrato llamada `ICounter`.

> **Nota:** Cualquier otro nombre dado a la interfaz del contrato rompería el test, ¡asegúrate de tener el nombre correcto!

### Verificación

Cuando completes, ejecuta la suite de tests para verificar que has cumplido con todos los requisitos de esta sección.

```
scarb test
```

### Consejos

- Las variables de Storage son la forma más común de interactuar con el almacenamiento de tu contrato. Puedes leer más sobre esto en el [Capítulo 12.3.1 - Storage de Contratos](https://book.cairo-lang.org/ch14-01-contract-storage.html#contract-storage).
- La función del constructor es un tipo especial de función que se ejecuta solo una vez. Puedes leer más sobre esto en el [Capítulo 12.3.2 - Función de Constructor](https://book.cairo-lang.org/ch14-02-contract-functions.html#1-constructors).
- Para crear una interfaz de contrato, necesitarás definir un trait con el nombre `ICounter` (de lo contrario, los tests fallarán) y marcar el trait con el atributo `[starknet::interface]`. Puedes leer más sobre esto en el [Capítulo 12.5 Interfaces](https://book.cairo-lang.org/ch15-01-abis-and-contract-interfaces.html#interface).
- La función `get_counter()` solo debería poder leer el estado del contrato y no modificarlo. Puedes leer más sobre esto en el [Capítulo 12.3.2 - Funciones de Lectura](https://book.cairo-lang.org/ch14-02-contract-functions.html#view-functions).

## Paso 2

Crea una rama `step2` para habilitar los tests de verificación para esta sección.

```bash
git checkout -b step2 origin/step2
```

O Simplemente cambia de rama a `step2` si ya la tienes creada.

```bash
git checkout step2
```

Si te quedaste atrás, el archivo `prev_solution.cairo` contiene la solución al paso anterior.

### Objetivo

Implementa una función llamada `increase_counter()` que pueda incrementar el valor actual del `counter` en `1` cada vez que se invoque.

### Verificación

Cuando completes, ejecuta la suite de tests para verificar que has cumplido con todos los requisitos de esta sección.

```
scarb test
```

### Consejos

- La función `increase_counter()` debe ser capaz de modificar el estado del contrato (también llamada una función externa) y actualizar el valor de `counter` dentro de `Storage`. Puedes leer más sobre esto en el [Capítulo 12.3.2 - Funciones Externas](https://book.cairo-lang.org/ch14-02-contract-functions.html#external-functions).

## Paso 3

Crea una rama `step3` para habilitar los tests de verificación para esta sección.

```bash
git checkout -b step3 origin/step3
```

O Simplemente cambia de rama a `step3` si ya la tienes creada.

```bash
git checkout step3
```

Si te quedaste atrás, el archivo `prev_solution.cairo` contiene la solución al paso anterior.

### Objetivo

En este paso, necesitarás hacer lo siguiente:

1. Importar la interfaz del contrato `KillSwitch` a tu proyecto.
2. Almacenar una variable llamada `kill_switch` como tipo `IKillSwitchDispatcher` en `Storage`.
3. Actualizar la función del constructor para recibir una variable de entrada adicional con el tipo `ContractAddress`.
4. Actualizar la función del constructor para inicializar la variable `kill_switch` con la nueva variable de entrada añadida. Ten en cuenta que necesitas usar `IKillSwitchDispatcher` que espera un `ContractAddress` como su tipo.

> **Nota:** Analiza el código de `KillSwitch` para entender la interfaz y la estructura del contrato desde [aquí](https://github.com/starknet-edu/kill-switch/blob/master/src/lib.cairo). Esto ya está añadido como una dependencia en tu archivo `Scarb.toml`.

### Verificación

Cuando completes, ejecuta la suite de tests para verificar que has cumplido con todos los requisitos de esta sección.

```
scarb test
```

### Consejos

- Necesitas importar `Dispatcher` y `DispatcherTrait` del contrato KillSwitch. Estos despachadores son creados y exportados automáticamente por el compilador. Puedes encontrar más información sobre el Despachador de Contratos en el [Capítulo 12.5.2 - Despachador de Contratos](https://book.cairo-lang.org/ch15-02-contract-dispatchers-library-dispatchers-and-system-calls.html#contract-dispatcher).
- En el constructor, puedes actualizar la variable `kill_switch` con `IKillSwitchDispatcher { contract_address: ??? }`, que espera la dirección del contrato externo.

> **Nota:** Si deseas desplegar el contrato `Counter`, puedes usar la siguiente dirección del contrato `KillSwitch` desplegado.
>
> **Goerli**
>
> Dirección del Contrato: `0x033b2c899fd8f89e3e1d5b69c4d495f1018a1dbb8c19b18795c2e16b078da34d`
>
> - [Voyager](https://goerli.voyager.online/contract/0x033b2c899fd8f89e3e1d5b69c4d495f1018a1dbb8c19b18795c2e16b078da34d)
> - [Starkscan](https://testnet.starkscan.co/contract/0x033b2c899fd8f89e3e1d5b69c4d495f1018a1dbb8c19b18795c2e16b078da34d)
>
>**Sepolia**
>
> Dirección del Contrato: `0x048fd89591a02ee84a9080bf014889892c5600d2253b3d2da17fb37629b64f2f`
>
> - [Voyager](https://sepolia.voyager.online/contract/0x048fd89591a02ee84a9080bf014889892c5600d2253b3d2da17fb37629b64f2f)
> - [Starkscan](https://sepolia.starkscan.co/contract/0x048fd89591a02ee84a9080bf014889892c5600d2253b3d2da17fb37629b64f2f)
>

## Paso 4

Crea una rama `step4` para habilitar los tests de verificación para esta sección.

```bash
git checkout -b step4 origin/step4
```

O Simplemente cambia de rama a `step4` si ya la tienes creada.

```bash
git checkout step4
```

Si te quedaste atrás, el archivo `prev_solution.cairo` contiene la solución al paso anterior.

### Objetivo

Implementa el mecanismo `KillSwitch` en la función `increase_counter()` llamando a la función `is_active()` del contrato `KillSwitch`.

### Requisitos

- Si la función `is_active()` del contrato KillSwitch devuelve `true`, entonces permite que `increase_counter()` incremente el valor.
- Si la función `is_active()` del contrato KillSwitch devuelve `false`, entonces devuelve sin incrementar el valor.

### Verificación

Cuando completes, ejecuta la suite de tests para verificar que has cumplido con todos los requisitos de esta sección.

```
scarb test
```

### Consejos

- Puedes acceder a la función `is_active()` desde tu variable `kill_switch`. Usa esto para crear la lógica en la función `increase_counter()`.

## Paso 5

Crea una rama `step5` para habilitar los tests de verificación para esta sección.

```bash
git checkout -b step5 origin/step5
```

O Simplemente cambia de rama a `step5` si ya la tienes creada.

```bash
git checkout step5
```

Si te quedaste atrás, el archivo `prev_solution.cairo` contiene la solución al paso anterior.

### Objetivo

En este paso, necesitarás hacer lo siguiente:

1. Implementar un evento llamado `CounterIncreased` que emita el valor actual del `counter`.
2. Emitir este evento cuando la variable `counter` haya sido incrementada exitosamente.

### Verificación

Cuando completes, ejecuta la suite de tests para verificar que has cumplido con todos los requisitos de esta sección.

```
scarb test
```

### Consejos

- Los eventos son estructuras de datos personalizadas que son emitidas por un contrato. Puedes encontrar más información sobre Eventos en el [Capítulo 12.3.3 - Eventos de Contratos](https://book.cairo-lang.org/ch14-03-contract-events.html#contract-events).

## Paso 6 (Final)

Crea una rama `step6` para habilitar los tests de verificación para esta sección.

```bash
git checkout -b step6 origin/step6
```

O Simplemente cambia de rama a `step6` si ya la tienes creada.

```bash
git checkout step6
```

Si te quedaste atrás, el archivo `prev_solution.cairo` contiene la solución al paso anterior.

### Objetivo

Verifica que hayas creado correctamente un contrato de cuenta para Starknet ejecutando la suite completa de tests:

```bash
scarb test
```

Si la suite de tests pasa, felicidades, has creado tu primer Contrato Inteligente de Contador en Starknet.

