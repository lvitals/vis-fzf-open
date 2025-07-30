local M = {}

-- Default path for fzf
M.fzf_path = "fzf"

-- Default arguments (can be overridden in visrc.lua)
M.fzf_args = "--preview 'bat --style=numbers --color=always {}' --height=40%"
M.fzf_explorer_args = "--preview 'bat --style=numbers --color=always {}' --style=full --border --padding=1,2 --border-label=' File Explorer ' --input-label=' Search ' --header-label=' File Type ' --color='border:#aaaaaa,label:#cccccc' --color='preview-border:#9999cc,preview-label:#ccccff' --color='list-border:#669966,list-label:#99cc99' --color='input-border:#996666,input-label:#ffcccc' --color='header-border:#6699cc,header-label:#99ccff' --layout=reverse --height=100%"

-- Function to execute fzf with given arguments
local function run_fzf(args, vis, argv)
    local command = M.fzf_path .. " " .. args .. " " .. table.concat(argv, " ")
    
    -- Run the command and capture its output
    local file = io.popen(command, "r")
    if not file then
        vis:info("Error running fzf")
        return false
    end

    local output = file:read("*l") -- Read the first line of output (selected file)
    local success, msg, status = file:close()

    if status == 0 and output then
        -- Trim leading/trailing whitespace
        output = output:match("^%s*(.-)%s*$")
        -- Open the selected file
        vis:command(string.format("e %q", output))
    elseif status == 1 then
        vis:info("fzf: No match found.")
    elseif status == 2 then
        vis:info("fzf: Execution error.")
    elseif status == 130 then
        -- Do nothing for interrupt (e.g., <Esc> or <C-c>), just return to Vis
    else
        vis:info(string.format("fzf: Unknown exit status %s", status))
    end

    vis:feedkeys("<vis-redraw>") -- Force screen redraw
    return true
end

-- Command configurations
local commands = {
    fzf = {
        handler = function(argv, force, win, selection, range)
            return run_fzf(M.fzf_args, vis, argv)
        end
    },
    fzfexplorer = {
        handler = function(argv, force, win, selection, range)
            return run_fzf(M.fzf_explorer_args, vis, argv)
        end
    }
}

-- Register commands
for cmd_name, cmd_config in pairs(commands) do
    vis:command_register(cmd_name, cmd_config.handler)
end

return M