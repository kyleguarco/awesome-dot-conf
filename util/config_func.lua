-- config_func.lua (Global scope)
--
-- Defines the function 'get_config_dir' globally to avoid typing things like
-- "/home/kyleg/.config/awesome" everywhere.

function get_config_dir()
    return os.getenv("HOME").."/.config/awesome/"
end
