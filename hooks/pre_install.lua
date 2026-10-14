local release = require("lib/release")

function PLUGIN:PreInstall(ctx)
  local filename = release.asset_name(ctx.version)
  return {
    version = ctx.version,
    url = release.base_url .. ctx.version .. "/" .. filename,
    sha256 = release.checksum(ctx.version, filename),
  }
end