# Margia — Conoce tu costo. Cuida tu margen.

Costeo estándar para negocios que producen: materias primas, mano de obra directa y costos indirectos (CIF), con órdenes de producción, variaciones, inventario, reportes en Excel y PDF, usuarios con permisos y respaldos automáticos. **Funciona en tu computador, sin internet.**

## En 4 pasos

1. Instala **Python** (una sola vez).
2. Instala las librerías: `python -m pip install -r requirements.txt` (una sola vez, con internet).
3. Inicia el programa: `python iniciar.py`
4. Entra con **admin** / **admin123** y cambia la contraseña.

Abajo está el detalle de cada paso.

---

## 1. Qué necesitas antes de iniciar

| Necesitas | Detalle |
|---|---|
| **Un computador** | Windows 10 u 11. También corre en Mac y Linux con Python. |
| **Python 3.10 o superior** | Descárgalo de https://www.python.org/downloads/. En Windows, al instalar, **marca la casilla «Add python.exe to PATH»**. Comprueba con `python --version`. Se probó con Python 3.12 y se ha usado también con 3.14. |
| **Tres librerías** (Excel, PDF e imágenes) | `python -m pip install -r requirements.txt`. Necesitas internet **solo para este paso**; después no. Sin ellas el programa abre y puedes entrar, pero Excel, PDF e importar no funcionan (el sistema te dice qué falta). |
| **Un navegador actualizado** | Chrome, Edge o Firefox. |
| **Poder escribir en la carpeta del programa** | Ahí se guarda tu base de datos (`data\costos.db`). No lo pongas en «Archivos de programa». Se recomienda tampoco usar una carpeta sincronizada con OneDrive o Dropbox: el archivo de la base se puede dañar si se copia justo mientras se guarda. |

No hay que instalar ninguna base de datos ni servidor: todo viene incluido.

**Comprueba que todo está listo** (opcional, pero recomendado la primera vez):

```
python iniciar.py --verificar
```

Debe terminar con `RESULTADO: todo listo.` Si algo falta, te dice qué.

---

## 2. Cómo iniciarlo

1. Descomprime `margia.zip` en una carpeta fija, por ejemplo `C:\Margia`.
   *Si venías de la versión anterior (Cifra), descomprímelo **junto a su carpeta `cifra`**: al primer arranque el programa te ofrece copiar tus datos (el original no se toca).*
2. Abre una terminal en esa carpeta. En Windows: abre la carpeta en el Explorador, haz clic en la barra de direcciones, escribe `cmd` y pulsa Enter.
3. Escribe:
   ```
   python iniciar.py
   ```
   Si Windows dice que «python» no se reconoce, prueba `py iniciar.py`.
4. Aparece una ventana negra con este mensaje, y el navegador se abre solo:
   ```
   Margia 1.0.0 funcionando.
     Datos guardados en: C:\Margia\data
     En este computador:   http://127.0.0.1:8765/
   Deja esta ventana abierta mientras uses el sistema. Cierra con Ctrl+C.
   ```
   Si el navegador no se abre, copia esa dirección en la barra del navegador.

**Deja la ventana negra abierta mientras uses Margia**: es el motor del programa.

> Si te entregaron una versión empaquetada (`Margia.exe`), haz doble clic en ese archivo en lugar de los pasos 2 y 3. Mira `installer/LEAME.txt`.

---

## 3. Cómo entrar

Al abrir el navegador verás la pantalla de **Iniciar sesión**. Los usuarios de fábrica son:

| Usuario | Contraseña | Qué puede hacer |
|---|---|---|
| `admin` | `admin123` | Todo: crear y editar datos, usuarios, respaldos. |
| `estudiante` | `estudiante123` | Consultar. El administrador decide qué más puede hacer, módulo por módulo. |

**Cambia la contraseña de inmediato**: las de fábrica son públicas (están en este mismo archivo).
- La primera vez que entres con una contraseña de fábrica se abre una ventana para cambiarla. Si eliges «Más tarde», verás un aviso amarillo en cada pantalla hasta que lo hagas.
- Puedes cambiarla cuando quieras con el botón **«Cambiar contraseña»**, arriba a la derecha. Mínimo 6 caracteres.

**Lo que debes saber de la sesión**
- Después de 5 intentos con una contraseña incorrecta, esa cuenta se bloquea durante 1 minuto.
- La sesión se cierra sola tras 2 horas sin usar el programa. Si ves «Tu sesión terminó», entra de nuevo.

**¿Olvidaste una contraseña?**
- Si es la de **otro usuario**, un administrador la cambia en **Usuarios → Editar → Nueva contraseña**.
- Si es la del **único administrador**, el programa **no tiene una forma automática de recuperarla**. Por eso conviene que **crees un segundo usuario con rol Administrador** (Usuarios → Nuevo usuario) y guardes las dos contraseñas en un lugar seguro.

---

## 4. Qué hacer después de entrar

El **Dashboard** muestra **«Tu ruta para empezar»**: 9 pasos, en el orden en que el sistema necesita los datos. Se marcan solos a medida que cargas tu información:

1. Crea tu empresa → 2. Crea un periodo contable (con sus unidades presupuestadas) → 3. Registra tus materias primas → 4. Registra la mano de obra → 5. Define los costos indirectos (CIF) → 6. Crea tus productos → 7. Arma la receta de cada producto → 8. Registra una orden de producción → 9. Captura los costos reales y ciérrala.

Si ya tienes tus datos en Excel, cada pantalla tiene **«Importar desde Excel»** (con su plantilla). La carpeta `plantillas` trae una para cada módulo.

Cómo se usa cada pantalla: `docs/MANUAL_USUARIO.md`.

---

## 5. Cerrar y volver a entrar

- **Cerrar el programa:** pulsa `Ctrl+C` en la ventana negra, o ciérrala.
- **Cerrar solo el navegador** no apaga el programa: sigue funcionando. Para volver a entrar abre el navegador en `http://127.0.0.1:8765/`, o ejecuta `python iniciar.py` otra vez (si ya estaba abierto, simplemente te abre el navegador).
- Al cerrar y abrir el programa **no se pierde nada**: todo queda guardado en `data\costos.db`.

---

## 6. Tus datos y respaldos

- Tu información está en **`data\costos.db`**, un solo archivo. Para moverla a otro computador, copia la carpeta `data`.
- Margia hace **una copia automática diaria** cada vez que se abre, en `data\respaldos` (conserva las últimas 14). La primera vez que lo abres todavía no hay nada que copiar; la primera copia aparece al abrirlo por segunda vez.
- Con el menú **Respaldo** (solo administrador) descargas una copia cuando quieras, y puedes restaurar una. **Guarda copias fuera de este computador** (memoria USB o la nube).

---

## 7. Usarlo desde otros computadores de la red (opcional)

Por defecto Margia solo se abre en el computador donde corre. Para que otros equipos de tu local entren por el navegador:

1. Primero cambia la contraseña de `admin`. Si no, **Margia se niega a abrirse a la red** (por seguridad).
2. En `config\config.ini` pon `host = 0.0.0.0` y reinicia el programa.
3. La ventana negra mostrará las direcciones para los demás equipos (`http://192.168.x.x:8765/`). Es posible que Windows pida permiso en el firewall.

La conexión **no está cifrada**: úsalo solo en una red de confianza, nunca expuesto a internet. Más detalles en `docs/DESPLIEGUE.md`.

---

## 8. Si algo falla

| Qué ves | Qué hacer |
|---|---|
| «python» no se reconoce como un comando | Vuelve a instalar Python marcando **Add python.exe to PATH**, o prueba con `py iniciar.py`. |
| «Falta la librería openpyxl» (o reportlab) | Ejecuta `python -m pip install -r requirements.txt`. |
| El navegador no se abre solo | Copia en el navegador la dirección que muestra la ventana negra (`http://127.0.0.1:8765/`). |
| «No se pudo abrir el puerto 8765: otro programa lo está usando» | Cambia `puerto` en `config\config.ini` (por ejemplo a `8766`) y vuelve a abrirlo. |
| La ventana negra se cierra sola al arrancar | Abre `data\margia_errores.log`: ahí queda el motivo. Envíaselo a quien te instaló el programa. |
| «Tu sesión terminó» | Entra de nuevo. También pasa cada vez que se reinicia el programa. |
| «Demasiados intentos fallidos» | Esa cuenta quedó bloqueada: espera el tiempo que indica el mensaje (1 minuto) e inténtalo otra vez. Las demás cuentas no se afectan. |

Más soluciones y la instalación en detalle: `docs/DESPLIEGUE.md`.

---

## Más información

- `docs/MANUAL_USUARIO.md` — cómo usar cada pantalla.
- `docs/DESPLIEGUE.md` — instalar, usar en red, respaldar, actualizar y resolver problemas.
- `docs/MANUAL_TECNICO.md` — arquitectura, modelo de datos y cómo extenderlo.
- `docs/MARCA.md` — nombre, frase, logo y colores.
- `tests/README.md` — pruebas automáticas.
