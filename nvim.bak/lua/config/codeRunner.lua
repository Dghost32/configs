local M = {}

function M.setup()
  local coderunner = require('code_runner')
  coderunner.setup({
    filetype = { -- put here the commands by filetype
      java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
      python = "python3 -u",
      typescript = "ts-node $fileName",
      javascript = "node $fileName",
      rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
      cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
      c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
      html = "firefox $fileName",
      default = "echo 'No command for filetype: $filetype' && exit 1",
    },
  })
end

return M
