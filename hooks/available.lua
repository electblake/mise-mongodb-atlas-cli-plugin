local release = require("lib/release")

function PLUGIN:Available(ctx)
  return release.list_versions()
end
