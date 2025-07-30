# vis-fzf-open

A plugin for the vis editor that integrates `fzf` for fast fuzzy file search and opening.

## Features

*   Use `fzf` to fuzzy-search and open files directly from vis.
*   Simple and minimal implementation.
*   Compatible with Lua 5.3+ and modern vis plugin loading system.
*   `:fzfexplorer` command with enhanced visuals and layout customization.
    

## Installation

1.  Place the plugin in your vis configuration directory:
    
    ~/.config/vis/plugins/vis-fzf-open.lua
    
2.  In your `~/.config/vis/init.lua`, load the plugin:
    
    require('plugins.vis-fzf-open')
    
      
    
    \-- Optionally, map it to a key (e.g., Alt+P):
    
    vis:map(vis.modes.NORMAL, "<M-p>", ":fzf\\n")
    

## Configuration

You can customize the `fzf` path and arguments, including enhanced styling for the explorer mode:

```
local fzf = require('plugins/vis-fzf-open')

fzf.fzf_args = "--preview 'bat --style=numbers --color=always {}' --height=40%"

fzf.fzf_explorer_args = "--preview 'bat --style=numbers --color=always {}' --style=full --border --padding=1,2 --border-label=' File Explorer ' --input-label=' Search ' --header-label=' File Type ' --color='border:#aaaaaa,label:#cccccc' --color='preview-border:#9999cc,preview-label:#ccccff' --color='list-border:#669966,list-label:#99cc99' --color='input-border:#996666,input-label:#ffcccc' --color='header-border:#6699cc,header-label:#99ccff' --layout=reverse --height=100%"

vis.events.subscribe(vis.events.INIT, function()

	--keyboard shortcuts--
	vis:command('map normal <M-p> :fzf<Enter>')
	vis:command('map normal <M-b> :fzfexplorer<Enter>')

end)
```

## Usage

### Quick Search

In normal mode, run:

:fzf

Or use the mapped key (e.g., Alt+P). The selected file will be opened immediately.

### Explorer Mode

Run:

:fzfexplorer

This version provides a styled UI with labels, borders, previews using `bat`, and a full-height reverse layout.

## Requirements

*   [fzf](https://github.com/junegunn/fzf) must be installed and available in your system PATH.
*   [bat](https://github.com/sharkdp/bat) is optional but recommended for file previews.
    

## License

This plugin is licensed under the [GNU Affero General Public License v3](https://www.gnu.org/licenses/agpl-3.0.html).