local M = {}

local ignored_dirs = {
  [".git"] = true,
  ["node_modules"] = true,
  ["vendor"] = true,
  ["dist"] = true,
  ["build"] = true,
  ["target"] = true,
  [".next"] = true,
  [".cache"] = true,
}

local function find_project_root(dir)
  local marker = vim.fs.find({
    ".git",
    "go.work",
    "pnpm-workspace.yaml",
    "package.json",
  }, {
    upward = true,
    path = dir,
  })[1]

  if not marker then
    return dir
  end

  if vim.fs.basename(marker) == ".git" then
    return vim.fs.dirname(marker)
  end

  return vim.fs.dirname(marker)
end

local function find_task_files(root)
  local files = {}

  local function scan(dir)
    local handle = vim.uv.fs_scandir(dir)

    if not handle then
      return
    end

    while true do
      local name, file_type = vim.uv.fs_scandir_next(handle)

      if not name then
        break
      end

      local path = vim.fs.joinpath(dir, name)

      if file_type == "directory" then
        if not ignored_dirs[name] then
          scan(path)
        end
      elseif file_type == "file" and name == "Tasks" then
        table.insert(files, path)
      end
    end
  end

  scan(root)

  return files
end

local function namespace_for(root, tasks_file)
  local task_dir = vim.fs.dirname(tasks_file)
  local relative = vim.fs.relpath(root, task_dir)

  if not relative or relative == "." then
    return "root"
  end

  return relative
end

---@type overseer.TemplateFileProvider
M = {
  condition = {
    callback = function(search)
      if vim.fn.executable("nu") ~= 1 then
        return false
      end

      local root = find_project_root(search.dir)

      return #find_task_files(root) > 0
    end,
  },

  cache_key = function(search)
    return find_project_root(search.dir)
  end,

  generator = function(search, callback)
    local root = find_project_root(search.dir)
    local task_files = find_task_files(root)

    if #task_files == 0 then
      callback("No tasks.nu found")
      return
    end

    local templates = {}
    local errors = {}
    local pending = #task_files

    local function finish_one()
      pending = pending - 1

      if pending > 0 then
        return
      end

      table.sort(templates, function(a, b)
        return a.name < b.name
      end)

      if #templates == 0 and #errors > 0 then
        callback(table.concat(errors, "\n"))
        return
      end

      callback(templates)
    end

    for _, tasks_file in ipairs(task_files) do
      local task_dir = vim.fs.dirname(tasks_file)
      local namespace = namespace_for(root, tasks_file)

      vim.system({
        "nu",
        tasks_file,
        "list",
        "--json",
      }, {
        cwd = task_dir,
        text = true,
      }, function(result)
        vim.schedule(function()
          if result.code ~= 0 then
            table.insert(
              errors,
              ("%s: %s"):format(tasks_file, result.stderr ~= "" and result.stderr or "Unable to read tasks")
            )

            finish_one()
            return
          end

          local ok, tasks = pcall(vim.json.decode, result.stdout)

          if not ok or type(tasks) ~= "table" then
            table.insert(errors, ("%s returned invalid JSON"):format(tasks_file))

            finish_one()
            return
          end

          for _, item in ipairs(tasks) do
            local task_name = item.name
            local display_name = ("nu [%s] %s"):format(namespace, task_name)

            table.insert(templates, {
              name = display_name,
              desc = item.description,

              builder = function()
                return {
                  name = display_name,
                  cmd = {
                    "nu",
                    tasks_file,
                    task_name,
                  },
                  cwd = task_dir,
                  components = {
                    "default",
                  },
                  metadata = {
                    runner = "nushell",
                    namespace = namespace,
                    source = tasks_file,
                    group = item.group,
                  },
                }
              end,
            })
          end

          finish_one()
        end)
      end)
    end
  end,
}

return M
