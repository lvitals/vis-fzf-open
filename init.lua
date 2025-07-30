local M = {}

-- Default path for fzf
M.fzf_path = "fzf"

-- Store registered commands and their configurations
local commands = {}

-- Command builder
local Command = {}
Command.__index = Command

function Command:new(name)
    local cmd = setmetatable({_args = ""}, Command)
    cmd.name = name
    return cmd
end

function Command:set_args(arg_string)
    self._args = arg_string
    commands[self.name] = {
        args = self._args,
        handler = function(argv, force, win, selection, range)
            return M.run_fzf(self._args, vis, argv)
        end
    }
    vis:command_register(self.name, commands[self.name].handler)
end

-- Add metatable for fluent-style assignment: cmd.args = "..."
setmetatable(Command, {
    __call = function(_, name) return Command:new(name) end
})

Command.__newindex = function(t, k, v)
    if k == "args" then
        t:set_args(v)
    else
        rawset(t, k, v)
    end
end

-- Function to execute fzf with given arguments
function M.run_fzf(args, vis, argv)
    local command = M.fzf_path .. " " .. args .. " " .. table.concat(argv, " ")

    local file = io.popen(command, "r")
    if not file then
        vis:info("Error running fzf")
        return false
    end

    local output = file:read("*l")
    local success, msg, status = file:close()

    if status == 0 and output then
        output = output:match("^%s*(.-)%s*$")
        vis:command(string.format("e %q", output))
    elseif status == 1 then
        vis:info("fzf: No match found.")
    elseif status == 2 then
        vis:info("fzf: Execution error.")
    elseif status == 130 then
        -- Do nothing for interrupt (e.g., <Esc> or <C-c>), just return to Vis
    else
        vis:info(string.format("fzf: Unknown exit status %s", tostring(status)))
    end

    vis:feedkeys("<vis-redraw>")
    return true
end

-- Fluent interface
function M:command(name)
    return Command(name)
end

-- Suporte a: fzf.args = "--..."
function M:set_args(arg_string)
    self:command('fzf').args = arg_string
end

-- Metatable para permitir fzf.args = "..." como atalho para fzf:set_args(...)
local mt = getmetatable(M) or {}
mt.__newindex = function(t, k, v)
    if k == "args" then
        M:set_args(v)
    else
        rawset(t, k, v)
    end
end
setmetatable(M, mt)

return M
