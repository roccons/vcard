# Tarjeta de Presentación Digital

Este proyecto es una tarjeta de presentación digital simple y auto-contenida. Está diseñada para ser fácilmente personalizable y no requiere dependencias complejas.

## Cómo crear una nueva tarjeta o actualizar los datos

Para adaptar esta tarjeta para otra persona o actualizar la información, sigue estos pasos:

### 1. Actualizar la Información de Contacto

-   **Archivo:** `contacto.vcf`
-   **Acción:** Edita este archivo con un editor de texto. Modifica los campos `FN` (Nombre completo), `TITLE` (Puesto), `TEL` (Teléfono), `EMAIL` (Correo) y `URL` (Sitio web) con la nueva información.

### 2. Cambiar las Imágenes

-   **Foto de perfil:** Reemplaza el archivo `foto.jpg` con la nueva imagen y codifícala en base64 para incluirla dentro del archivo `contacto.vcf`. Crea también una versión `foto.webp`que es la que se cargará dentro del html.
-   **Logo y Favicon:** En caso de rebranding reemplazar también los archivos `logo.webp` y `favicon.png`.

### 3. Actualizar el title y la Vista Previa para Redes Sociales

Para que el enlace compartido en WhatsApp y otras redes sociales muestre la información correcta, necesitas actualizar las metaetiquetas en el archivo `index.html`.

-   **Archivo:** `index.html`
-   **Acción:** Dentro de la etiqueta `<head>`, busca la etiqueta `<title>` y actualiza su contenido con el nuevo nombre.
-   **Acción:** Dentro de la etiqueta `<head>`, busca las etiquetas `meta` con las propiedades `og:title`, `og:description`, y `og:image`.
    -   Actualiza `content` en `og:title` y `og:description` con el nuevo nombre, puesto y descripción.
    -   Asegúrate de que la ruta en `og:image` apunte a la imagen de perfil correcta (ej. `foto.jpg`).

Una vez completados estos pasos, la tarjeta de presentación estará actualizada con la nueva información.
