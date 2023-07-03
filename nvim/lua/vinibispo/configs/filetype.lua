vim.filetype.add({
  pattern = {
    [".*/.*%.json.jbuilder"] = "ruby",
    [".*/.*%.xlsx.axlsx"] = "ruby",
  },
})
