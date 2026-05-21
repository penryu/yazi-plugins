--- @since 26.5.6

local PLUGIN_NAME = 'repotool'
local DEFAULT_CONFIG = { git = 'gitui', jj = 'jjui' }

-- For development
local function notify(msg) ya.notify { title = PLUGIN_NAME, content = msg, timeout = 5 } end

local function is_git_repo()
  local output = Command('git'):arg('status'):stderr(Command.PIPED):output()
  ya.dbg(output)
  return output.stderr == ''
end

local function is_jj_repo()
  local output = Command('jj'):arg('root'):stderr(Command.PIPED):output()
  ya.dbg(output)
  return output.stderr == ''
end

local get_config = ya.sync(function(st)
  if st.config == nil then
    st.config = DEFAULT_CONFIG
  end

  ya.dbg { loading_config = st.config }
  return st.config
end)

local set_config = ya.sync(function(st, cfg)
  ya.dbg { setting_config = cfg }
  st.config = cfg
end)

local launch_tool = function(cmd)
  ya.dbg(cmd)
  ya.emit('shell', { cmd, block = true, confirm = false })
end

return {
  ---User arguments for setup method
  ---@class SetupArgs
  ---@field git string Tool to launch for git repository
  ---@field jj string Tool to launch for jj repository

  --- Setup plugin
  --- @param st table State
  --- @param args SetupArgs|nil
  setup = function(_, args)
    local cfg = DEFAULT_CONFIG

    for k, v in pairs(args) do
      notify('setting ' .. k .. ' = ' .. v)
      cfg[k] = v
    end

    set_config(cfg)
  end,

  entry = function(_)
    local cfg = get_config()

    if is_jj_repo() then
      launch_tool(cfg.jj)
    elseif is_git_repo() then
      launch_tool(cfg.git)
    else
      ya.notify {
        title = PLUGIN_NAME,
        content = 'Not a recognized repository',
        level = 'warn',
        timeout = 3,
      }
    end
  end,
}
