# vulpinelogic_uri

URI class for parsing URIs

## Features

- GDScript-native URI parser mainly intended for use by other VulpineLogic addons

## Installation

### Using the Asset Library

This addon may be submitted to the Asset Library once it reaches a 1.0.0 release. There is no estimated release date.

### Manual installation

Manual installation lets you use pre-release versions of this add-on by
following its `main` branch.

- Clone this Git repository:

```bash
git clone https://github.com/vulpinelogic/vl-godot-addon-uri.git
```

Alternatively, you can
[download a ZIP
archive](https://github.com/vulpinelogic/vl-godot-addon-uri/archive/master.zip)
if you do not have Git installed.

- Move the `addons/` folder to your project folder.
- In the editor, open **Project > Project Settings**, go to **Plugins**
  and enable the **vulpinelogic_uri** plugin.

## Usage

**This addon has only been tested with Godot 4.x**

```gdscript
var uri = VulpineLogicURI.new(uri_string)
```

The `VulpineLogicURI` class is a temporary solution to Godot's lack of a built in URI parsing capability. There are likely more complete and correct parser addons available elswhere. We are happy to accept PRs to improve this one. In its current form, it is designed to fill functionality gaps encountered while building other VulpineLogic addons.

## License

Copyright © 2025 VulpineLogic and contributors

Unless otherwise specified, files in this repository are licensed under the
MIT license. See [LICENSE.md](LICENSE.md) for more information.
