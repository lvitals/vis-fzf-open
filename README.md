vis-fzf-open
============

A plugin for the vis editor that integrates fzf to quickly open files using fuzzy search.

Features
--------

- Use `fzf` to fuzzy-search and open files directly from vis.
- Simple and minimal implementation.
- Compatible with Lua 5.3+ and modern vis plugin loading.

Installation
------------

1. Place the plugin in your vis configuration directory:
```
   ~/.config/vis/plugins/vis-fzf-open.lua
```
2. In your ~/.config/vis/init.lua, load the plugin:
```
   require('plugins.vis-fzf-open')

   -- Optionally, map it to a key (e.g., Alt+P):
   vis:map(vis.modes.NORMAL, "<M-p>", ":fzf\n")
```
Configuration
-------------

You can customize the fzf path and arguments in init.lua:
```
   local fzf = require('plugins.vis-fzf-open')
   fzf.fzf_path = "fzf"
   fzf.fzf_args = "--preview 'bat --style=numbers --color=always {}' --height=40%"
```
Usage
-----

In normal mode, run:
```
   :fzf
```
Or use the mapped key (e.g., Alt+P). The selected file will be opened immediately in vis.

Requirements
------------

- fzf must be installed and available in your system PATH.

License
-------

This plugin is licensed under the GNU Affero General Public License v3.
See https://www.gnu.org/licenses/agpl-3.0.html for full details.

