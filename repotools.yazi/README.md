# repotools.yazi

Plugin for [Yazi](https://github.com/sxyazi/yazi) to manage multiple repo types.


## Dependencies

Make sure any specified tools are installed and on your path.

The default tools are:

- `jjui` for Jujutsu repositories
- `gitui` for Git repositories


## Installation

### Using `ya pkg`

```
 ya pkg add https://git.penryu.dev/penryu/yazi-plugins:repotools
```


## Configuration

Map this plugin to a keymap in your **keymap.toml** file.

```toml
[[mgr.prepend_keymap]]
on   = [',', 'j']
run  = "plugin repotools"
desc = "Run appropriate tool for current repository"
```

To override the above default tools, add the following to your `init.lua`:

```lua
require('repotools'):setup { jj = 'lazyjj', git = 'lazygit' }
```

This is just a suggested keybinding. Please choose whichever keybinding works best with your
workflow. Please refer to the [keymap.toml](https://yazi-rs.github.io/docs/configuration/keymap)
documentation for details.
