-- plugins/fzf-open.lua

local M = {}

-- Default path and arguments for fzf
M.fzf_path = "fzf"
M.fzf_args = ""

-- :fzf command to open the selected result
vis:command_register("fzf", function(argv, force, win, selection, range)
    local command = M.fzf_path .. " " .. M.fzf_args .. " " .. table.concat(argv, " ")
    
    -- Run the command and capture its output
    local file = io.popen(command, "r")
    if not file then
        vis:info("Error running fzf")
        return false
    end

    local output = file:read("*l")  -- Read the first line of output (selected file)
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
        vis:info("fzf: Interrupted (probably <C-c>).")
    else
        vis:info(string.format("fzf: Unknown exit status %s", status))
    end

    vis:feedkeys("<vis-redraw>")  -- Force screen redraw
    return true
end)

return M
