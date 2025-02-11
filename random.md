Paleta de colores de `gruvbox`: 
```lua
gruvbox_colors = {
    fondo_oscuro = "#282828",
    fondo_claro = "#fbf1c7",
    texto_claro = "#ebdbb2",
    texto_oscuro = "#3c3836",
    rojo = "#cc241d",
    verde = "#8ec07c",
    amarillo = "#d79921",
    azul = "#458588",
    cian = "#83a598",
    magenta = "#d3869b",
    naranja = "#fe8019",
    gris_claro = "#a89984",
    gris_oscuro = "#7c6f64"
}
```

Paleta de colores de `oldworld`: 
```lua
oldworld = {
    bg = "#1c1c1c",
    fg = "#c9c7cd",
    subtext1 = "#b4b1ba",
    subtext2 = "#9f9ca6",
    subtext3 = "#8b8693",
    subtext4 = "#6c6874",
    bg_dark = "#131314",
    black = "#27272a",
    red = "#ea83a5",
    green = "#90b99f",
    yellow = "#e6b99d",
    purple = "#aca1cf",
    magenta = "#e29eca",
    orange = "#f5a191",
    blue = "#92a2d5",
    cyan = "#85b5ba",
    bright_black = "#353539",
    bright_red = "#f591b2",
    bright_green = "#9dc6ac",
    bright_yellow = "#f0c5a9",
    bright_purple = "#b9aeda",
    bright_magenta = "#ecaad6",
    bright_orange = "#ffae9f",
    bright_blue = "#a6b6e9",
    bright_cyan = "#99c9ce",
    gray0 = "#18181a",
    gray1 = "#1b1b1c",
    gray2 = "#2a2a2c",
    gray3 = "#313134",
    gray4 = "#3b3b3e",
    gray5 = "#5b5b5b",
}
```

# Carousel with Css and Html only

```css
* {
    box-sizing: border-box;
}

.slider {
width: 300px;
       text-align: center;
overflow: hidden;
}

.slides {
display: flex;

         overflow-x: auto;
         scroll-snap-type: x mandatory;



         scroll-behavior: smooth;
         -webkit-overflow-scrolling: touch;

         /*
            scroll-snap-points-x: repeat(300px);
            scroll-snap-type: mandatory;
          */
}
.slides::-webkit-scrollbar {
width: 10px;
height: 10px;
}
.slides::-webkit-scrollbar-thumb {
background: black;
            border-radius: 10px;
}
.slides::-webkit-scrollbar-track {
background: transparent;
}
.slides > div {
    scroll-snap-align: start;
    flex-shrink: 0;
width: 300px;
height: 300px;
        margin-right: 50px;
        border-radius: 10px;
background: #eee;
            transform-origin: center center;
transform: scale(1);
transition: transform 0.5s;
position: relative;

display: flex;
         justify-content: center;
         align-items: center;
         font-size: 100px;
}
.slides > div:target {
    /*   transform: scale(0.8); */
}
.author-info {
background: rgba(0, 0, 0, 0.75);
color: white;
padding: 0.75rem;
         text-align: center;
position: absolute;
bottom: 0;
left: 0;
width: 100%;
margin: 0;
}
.author-info a {
color: white;
}
img {
    object-fit: cover;
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 100%;
}

.slider > a {
display: inline-flex;
width: 1.5rem;
height: 1.5rem;
background: white;
            text-decoration: none;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
margin: 0 0 0.5rem 0;
position: relative;
}
.slider > a:active {
top: 1px;
}
.slider > a:focus {
background: #000;
}

/* Don't need button navigation */
@supports (scroll-snap-type) {
    .slider > a {
display: none;
    }
}

html, body {
height: 100%;
overflow: hidden;
}
body {
display: flex;
         align-items: center;
         justify-content: center;
background: linear-gradient(to bottom, #74ABE2, #5563DE);
            font-family: 'Ropa Sans', sans-serif;
}
```

```html
<div class="slider">
  
  <a href="#slide-1">1</a>
  <a href="#slide-2">2</a>
  <a href="#slide-3">3</a>
  <a href="#slide-4">4</a>
  <a href="#slide-5">5</a>

  <div class="slides">
    <div id="slide-1">
      1
    </div>
    <div id="slide-2">
      2
    </div>
    <div id="slide-3">
      3
    </div>
    <div id="slide-4">
      4
    </div>
    <div id="slide-5">
      5
    </div>
  </div>
</div>
```
