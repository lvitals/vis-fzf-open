vis-fzf-open
============

A plugin for the vis editor that integrates `fzf` for fast fuzzy file search and opening.

Features
--------

* Use `fzf` to fuzzy-search and open files directly from vis.
* Simple and minimal implementation.
* Compatible with Lua 5.3+ and the modern vis plugin loading system.
* Supports custom commands and visual configuration (e.g., explorer mode).

Installation
------------

1. Place the plugin in your vis configuration directory:

   ~/.config/vis/plugins/vis-fzf-open/init.lua

2. In your ~/.config/vis/visrc.lua, load the plugin:

```lua
   local fzf = require('plugins/vis-fzf-open')

   Optionally, map it to keys (e.g., Alt+P):

   vis.events.subscribe(vis.events.INIT, function()
       vis:command('map normal <M-p> :fzf<Enter>')
       vis:command('map normal <M-b> :fzfexplorer<Enter>')
   end)
```

Configuration
-------------

You can configure arguments for different `fzf` commands using properties:

```lua
local fzf = require('plugins/vis-fzf-open')

-- Set default arguments for the :fzf command
fzf.args = "--preview 'bat --style=numbers --color=always {}' --height=40%"

-- Set custom arguments for explorer command
fzf:command('fzfexplorer').args = "--preview 'bat --style=numbers --color=always {}' --style=full --border --padding=1,2 --border-label=' File Explorer ' --input-label=' Search ' --header-label=' File Type ' --color='border:#aaaaaa,label:#cccccc' --color='preview-border:#9999cc,preview-label:#ccccff' --color='list-border:#669966,list-label:#99cc99' --color='input-border:#996666,input-label:#ffcccc' --color='header-border:#6699cc,header-label:#99ccff' --layout=reverse --height=100%"

-- Define additional commands if needed
fzf:command('fzfcustom').args = "--preview 'cat {}' --height=30%"
```

Usage
-----

Quick Search

Use the command :fzf or the mapped key (e.g., <M-p>). This opens a fuzzy finder to locate files quickly.

Explorer Mode

Use :fzfexplorer to open the enhanced file explorer interface with border, labels, and previews powered by `bat`.

Custom Commands

You can define any number of custom `fzf` commands with unique styles and behaviors using:

fzf:command('mycommand').args = "--your-fzf-options-here"

Requirements
------------

* fzf must be installed and available in your system PATH.
* bat is optional but recommended for file preview.

License
-------

This plugin is licensed under the MIT