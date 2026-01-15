# Tarjeta de Presentación Digital

Este proyecto es una tarjeta de presentación digital simple y auto-contenida. Está diseñada para ser fácilmente personalizable y se actualiza automáticamente a través de un script.

## Cómo actualizar los datos

Para adaptar esta tarjeta para otra persona o actualizar la información, sigue estos pasos:

### 1. Actualizar la Información de Contacto

-   **Archivo:** `datos.json`
-   **Acción:** Edita este archivo con un editor de texto. Modifica los campos con la nueva información. El formato del teléfono puede incluir espacios para una mejor visualización y debe contener exactamente 10 dígitos más el código de país (ej. `+52 55 1234 5678`); el script se encargará de formatearlo correctamente.

### 2. Cambiar las Imágenes

-   **Foto de perfil:** Reemplaza el archivo `foto.jpg` con la nueva imagen, así como una versión en webp que se usará en el html. El script codificará la versión jpg para el vCard automáticamente.
-   **Logo y Favicon:** Si es necesario, reemplaza los archivos `logo.webp` y `favicon.png`.

### 3. Generar los Archivos

Una vez que hayas actualizado `datos.json` y las imágenes, simplemente ejecuta el siguiente comando en tu terminal:

```bash
./generar_vcard.sh
```

Este script se encargará de:
-   Crear el archivo `contacto.vcf` con la información y la foto codificada.
-   Generar el archivo `index.html` con todos los datos actualizados, incluyendo los necesarios para la vista previa en redes sociales.

Se recomienda usar el archivo robots.txt en la raíz del sitio web en el que se quiera publicar la tarjeta de presentación digital para evitar que sus archivos sean indexados por motores de búsqueda.

### Requisitos

-   **jq:** Asegúrate de tener `jq` instalado, ya que el script lo necesita para leer el archivo `datos.json`. Puedes instalarlo en la mayoría de los sistemas con `sudo apt-get install jq` o `brew install jq`.
