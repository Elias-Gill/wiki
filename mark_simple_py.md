# Documentation

## GTK bindings for python

- [GTK python start guide](https://pygobject.readthedocs.io/en/latest/)
- [Testing and building](https://pygobject.readthedocs.io/en/latest/devguide/building_testing.html)
- [enviroment setup](https://pygobject.readthedocs.io/en/latest/devguide/dev_environ.html)

Dependencias necesarias para un ambiente de desarrollo:

```sh
sudo pacman -S --noconfirm python-wheel pyenv python-pipx gtk3
sudo pacman -S --noconfirm base-devel openssl zlib git gobject-introspection webkit2gtk
pipx install poetry
```

Para el correcto funcionamiento de `pyright`, se debe anadir los stubs necesarios:

```sh
pip install pygobject-stubs --no-cache-dir --config-settings=config=Gtk3 # or Gkt4, solo se puede tener uno a la vez
```

Configuracion de pyright:

```json
{
  "executionEnvironments": [{ "root": "mardown" }],
  "venvPath": "$HOME/.cache/pypoetry/virtualenvs/",
  "venv": "mardown-Om3lgSru-py3.11",
  "useLibraryCodeForTypes": false
}
```

## GTK3 documentation

[Tutorial GTK](https://python-gtk-3-tutorial.readthedocs.io/en/latest/)
[WEbKit2 documentation](https://lazka.github.io/pgi-docs/#WebKit-6.0/classes/WebView.html#WebKit.WebView.load_html)

## highlighter documentation

[highlighter](https://pygments.org/docs/)

## Pyinstaller

[PyInstaller](https://pyinstaller.org/en/stable/)

## Poetry usage

[Oficial Documentation](https://python-poetry.org/docs/basic-usage/)

Para la configuracion del proyecto modificar el archivo "pyproject.toml".
Ejemplo:

```toml
[tool.poetry]
name = "project name"
version = "0.1.0"
description = "Descripcion del proyecto"
authors = ["Autor <mail@mail.com>"]
readme = "README.md"

[tool.poetry.dependencies]
python = ">=3.11,<3.13"

# autogenerado
[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

### Comandos basicos:

```sh
poetry init # anadir un proyecto ya creado
poetry new # nuevo proyecto desde 0
poetry add <package> [version]
poetry remove [package]
poetry install # instalar dependencias
poetry upgrade [package] # actualizar paquete
```
