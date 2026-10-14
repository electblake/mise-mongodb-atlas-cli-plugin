local http = require("http")
local json = require("json")

local M = {}
M.base_url = "https://github.com/mongodb/mongodb-atlas-cli/releases/download/v"

function M.asset_name(version)
  local platforms = {
    windows = { name = "windows", extension = ".zip" },
    darwin = { name = "macos", extension = ".zip" },
    linux = { name = "linux", extension = ".tar.gz" },
  }
  local architectures = { amd64 = "x86_64", arm64 = "arm64" }
  local platform = platforms[RUNTIME.osType]
  return "mongodb-atlas-cli_" .. version .. "_" .. platform.name .. "_"
    .. architectures[RUNTIME.archType] .. platform.extension
end

function M.list_versions()
  local versions = {}
  local page = 1
  local releases
  repeat
    local response = http.get({
      url = "https://api.github.com/repos/mongodb/mongodb-atlas-cli/releases?per_page=100&page=" .. page,
      headers = { Accept = "application/vnd.github+json" },
    })
    releases = json.decode(response.body)
    for _, release in ipairs(releases) do
      if not release.draft and not release.prerelease then
        local version = release.tag_name:match("^v(%d+%.%d+%.%d+)$")
        if version then
          table.insert(versions, { version = version })
        end
      end
    end
    page = page + 1
  until #releases < 100
  return versions
end

function M.checksum(version, filename)
  local response = http.get({ url = M.base_url .. version .. "/checksums.txt" })
  local checksums = {}
  for digest, name in response.body:gmatch("(%x+)%s+([^\r\n]+)") do
    checksums[name] = digest
  end
  -- A missing entry must not become an unchecked download (nil sha256).
  return checksums[filename]:lower()
end

return M