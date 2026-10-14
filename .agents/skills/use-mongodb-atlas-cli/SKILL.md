---
name: use-mongodb-atlas-cli
description: Use the MongoDB Atlas CLI supplied by this mise plugin to inspect and manage MongoDB Atlas resources.
---

# Use MongoDB Atlas CLI

This plugin installs the official MongoDB Atlas CLI and adds its `bin`
directory to PATH.

| Command | Purpose |
| --- | --- |
| `atlas` | Inspect and manage MongoDB Atlas resources from the command line. |

The mise tool name is `mongodb-atlas-cli`; its executable is `atlas`.
The mise registry name `atlas` belongs to Ariga Atlas, a different tool.
This plugin does not supply `mongosh`, MongoDB Database Tools, or Docker.

With mise activated and `mongodb-atlas-cli` enabled, run `atlas` directly.
Without shell activation, invoke it through mise:

```powershell
mise exec -- atlas --version
mise exec -- atlas --help
```

Consult `atlas --help` and the selected subcommand's `--help` for
installed-version commands and options. Use the user's requested authentication
profile, organization, project, and resources when composing an operation;
keep Atlas changes within the requested scope. Let command failures surface
without retries or substituting another tool or profile.

For plugin setup, see the repository [README](../../../README.md). For command
details, see the [official MongoDB Atlas CLI documentation](https://www.mongodb.com/docs/atlas/cli/current/).
