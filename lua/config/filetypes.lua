vim.filetype.add({
  pattern = {
    -- Ansible YAML
    [".*playbook%.ya?ml"] = "yaml.ansible",
    [".*site%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",

    [".*%.ya?ml%.j2"] = "yaml",
    [".*%.yml%.j2"] = "yaml",
  },
})
