-- util/config_func.lua (global scope)
-- Defines the function `get_config_dir` globally to avoid typing things like
-- "/home/kyleg/.config/awesome" everywhere.
-- Similarly, provides `asset` to obtain asset paths.

function get_home_dir()
    return os.getenv("HOME").."/"
end

function get_config_dir()
    return os.getenv("HOME").."/.config/awesome/"
end

function asset(assetname)
    return get_config_dir().."assets/"..assetname
end
