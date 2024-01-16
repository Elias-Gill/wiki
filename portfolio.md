# Encountered problems
- React icons [incomplatibilities](https://github.com/withastro/astro/issues/7629) in newer versions. Use 4.8.0

## What Should a Back-End Web Developer Portfolio Have?
- Homepage
- Skills Page
- Projects Page
- Resume
- Display the Best Projects
- Create Customized Pages
- Pay Attention to User Experience
- Mention the Awards or Special Recognition

# Fonts (como llamarlas desde CSS)

_INFO_: los titulos tambien son sus nombres de clase CSS
titulo - font-family: 'Secular One', sans-serif;
texto - font-family: 'Murecho', sans-serif;

# Tailwind

- Para cambiar de fuente: font-<fuente>
- Para padding: px-... o py-...

# Astrojs

## Estructura de carpetas en Astro

- En la carpeta _index_ se encuentran todas las paginas que se van a mostrar y astro renderiza de a uno
- Entiendo que para las paginas que va a tener tu blog metes las paginas dentro de _pages_. Podes poner paginas individuales o podes crear carpetas que son como los _endpoints de una api_. Dentro de esa carpeta Astro busca por el archivo _index.astro_. Para hacer Referencias a estas paginas agregas el nombre del archivo o carpeta en el index (funciona recursivamente, como los _endpoints_ de una API).
- _BaseHead_ parece ser la metadata del archivo, mejor no tocar la config original de astro.
- El archivo _[...slug].astro_ se utiliza como comodin (o plantilla) en funcion al url que se proporciona. En este proyecto se esta trayendo todos el contenido dentro de 'content/blog/' utilizando la funcion:

- Dentro de la carpeta donde se crea una nueva coleccion ("content") se debe poner en config.ts la configuracion de la coleccion:

### Layout vs components
Los componentes son nada de 

## Sintaxis de astro

- En astro todo lo que esta entre tres guiones (---) es <script></script>

- Los layouts sirven para poder hacer eso, marcos de aplicacion pero cuando usas markdown supongo, son invocados automáticamente por AstroJS. Se encuentran en la carpeta 'layouts'. Dentro de los layouts
  puedo tener diferentes elementos, de los cuales el mas importante seguro es _<slot />_ el cual se utiliza para inyectar html
  externo al momento de utilizar el layout.

```astro
---
import type { HTMLAttributes } from 'astro/types';

type Props = HTMLAttributes<'a'>;

const { href, class: className, ...props } = Astro.props;

const { pathname } = Astro.url;
const isActive = href === pathname || href === pathname.replace(/\/$/, '');
---

<a href={href} class:list={[className, { active: isActive }]} {...props}>
    <slot />
</a>
<style>
a {
    display: inline-block;
    text-decoration: none;
}
a.active {
    font-weight: bolder;
    text-decoration: underline;
}
</style>
```
## Mas importante de Astro

- _RSS_: Astro proporciona una generación rápida y automática de RSS feeds para blogs u otros sitios web con mucho contenido. Los feeds RSS proporcionan una forma fácil para que los usuarios se suscriban a tu contenido. Un feed RSS es una forma de distribuir contenido actualizado a los suscriptores de un sitio web. Permite a los usuarios recibir notificaciones automáticas cuando se publica nuevo contenido en el sitio.
- Los layouts definen la estructura general de una página y se utilizan para definir cómo se organizan los componentes en una página. Pueden ser utilizados en varias páginas que siguen la misma estructura general, pero con contenido diferente.
- Los componentes son bloques de construcción reutilizables que se utilizan para construir la UI. Pueden ser utilizados dentro de otros componentes o layouts para construir una UI más avanzada.

### Ejemplo config.ts de content
```typescript
import { defineCollection, z } from 'astro:content';

const works = defineCollection({
    // Type-check frontmatter using a schema
    schema: z.object({
        title: z.string(),
        description: z.string(),
        // Traesform string to Date object
        pubDate: z.string(),
        caption: z.string().optional(),
    }),
});

export const collections = { trabajos };
```

### Usage of a collection entry

```jsx
---
// para plantillas
type Props = CollectionEntry<'notas'>['data'];
const { titulo, descripcion } = Astro.props;

// usar dentro del index
const notas = (await getCollection('notas'))
---
```

### ...slug.astro
```jsx
---
import { CollectionEntry, getCollection } from 'astro:content';
import Note from '../../layouts/Note.astro';

export async function getStaticPaths() {
    const notas = await getCollection('notas');
    return notas.map((nota) => ({
        params: { slug: nota.slug },
        props: nota,
    }));
}
type Props = CollectionEntry<'notas'>;

const post = Astro.props;
const { Content } = await post.render();
---

<Note {...post.data}>
    <h1>{post.data.titulo}</h1>
    <Content />
</Note>
```

## Hidratacion
La hidratacion se puede realizar utilizando las "anotaciones" en los elementos html o react o lo que sea
que queremos que se carguen de manera "perezosa" en el cliente.

```astro
<ThemeToggle client:visible/>
```
