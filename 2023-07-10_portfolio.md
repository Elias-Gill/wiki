# Fonts (como llamarlas desde CSS)
INFO: los titulos tambien son sus nombres de clase CSS
titulo
    - font-family: 'Secular One', sans-serif;
texto
    - font-family: 'Murecho', sans-serif;

## Tailwind
- Para cambiar de fuente: font-<fuente>
- Para padding: px-...  o  py-...

## Astrojs
- En astro todo lo que esta entre tres guiones (---) es <script></script>

- Entiendo que para las paginas que va a tener tu blog metes las paginas dentro
de _pages_. Podes poner paginas individuales o podes crear carpetas que son como los _endpoints de una api_. 
Dentro de esa carpeta Astro busca por el archivo *index.astro*.

- Para hacer Referencias a estas paginas agregas el nombre del archivo o carpeta en el index (funciona recursivamente, como los _endpoints_ de una API).

- El archivo _[...slug].astro_ se utiliza como comodin (o plantilla) en funcion al url que se proporciona. En este proyecto se esta trayendo todos el contenido dentro de 'content/blog/' utilizando la funcion:
```js
import { CollectionEntry, getCollection } from 'astro:content';
import BlogPost from '../../layouts/BlogPost.astro';

export async function getStaticPaths() {
    const posts = await getCollection('blog');
    return posts.map((post) => ({
        params: { slug: post.slug },
        props: post,
    }));
}
type Props = CollectionEntry<'blog'>;

const post = Astro.props;
const { Content } = await post.render();
```
y se le hace referencia nomas ya dentro usando
```html
<BlogPost {...post.data}>
    <h1>{post.data.title}</h1>
    <Content />
</BlogPost>
```
- BaseHead parece ser la metadata del archivo, mejor no tocar la config original de astro.

- Los layouts sirven para poder hacer eso, marcos de aplicacion pero cuando usas markdown supongo, son invocados automáticamente por AstroJS. Se encuentran en la carpeta 'layouts'. Dentro de los layouts
puedo tener diferentes elementos, de los cuales el mas importante seguro es _<slot />_ el cual se utiliza para inyectar html
externo al momento de utilizar el layout.
