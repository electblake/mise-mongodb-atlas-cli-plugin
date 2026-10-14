# MongoDB Atlas CLI plugin for mise

A single-tool Lua plugin that installs the official MongoDB Atlas CLI release
archives. The mise tool name is `mongodb-atlas-cli`; the executable is `atlas`.
The registry name `atlas` is already used by Ariga Atlas.

## Requirements and platforms

Developed and verified with mise 2026.10.9. Uses mise's built-in Lua runtime;
no separate Lua, Go, or MongoDB installation is needed.

| Platform | Architecture | Archive |
| --- | --- | --- |
| Windows | x64 | zip |
| macOS | x64, ARM64 | zip |
| Linux | x64, ARM64 | tar.gz |

Windows ARM64 has no native upstream asset. No architecture emulation is selected.
Older versions depend on the assets and checksums actually published upstream.
This plugin installs Atlas CLI only; features requiring mongosh, Docker, or other
software need those dependencies installed separately.

## Local use

Run from this plugin directory, including after moving it to its own project:

```sh
mise plugins link mongodb-atlas-cli .
mise ls-remote mongodb-atlas-cli
mise install mongodb-atlas-cli@1.59.2
mise exec mongodb-atlas-cli@1.59.2 -- atlas --version
mise exec mongodb-atlas-cli@1.59.2 -- atlas --help
mise which --tool mongodb-atlas-cli@1.59.2 atlas
```

Activate it in a consuming project with:

```sh
mise use mongodb-atlas-cli@1.59.2
```

Use `@latest` instead of a pinned version to select the newest stable release.
Relink after moving the plugin directory. `mise plugins uninstall mongodb-atlas-cli`
removes the link when it is no longer needed.

## Installation

```sh
mise plugins install mongodb-atlas-cli https://github.com/electblake/mise-mongodb-atlas-cli-plugin.git
mise use mongodb-atlas-cli@latest
atlas --version
```

## Implementation

- Pages through GitHub releases and lists stable `vMAJOR.MINOR.PATCH` tags.
- Downloads the platform archive from `mongodb/mongodb-atlas-cli`.
- Reads the exact filename's SHA-256 from the release's `checksums.txt`.
- Delegates verification and extraction to mise; exposes `bin` on PATH.
- Uses no recovery paths, checksum substitutions, or custom error handling.
  A missing checksum fails before the archive is handed to mise.

The checksum is fetched over HTTPS from the same release as the archive.
This verifies integrity against the published checksum; it does not verify
MongoDB's signing key or detached signatures.

mise handles GitHub authentication. Its HTTP client has its own retry policy;
set `MISE_HTTP_RETRIES=0` for fail-fast requests, as the CI workflow does.
A GitHub token can be supplied through mise's normal authentication configuration.

A built-in GitHub backend can also install release archives. This repository
provides the explicitly requested dedicated plugin with fixed platform naming,
checksum selection, and PATH behavior.

## Verification

Locally verified on Windows x64 with mise 2026.10.9 and Atlas CLI 1.59.2:
release listing, checksum-verified installation, version output, help output, and
executable resolution. Testing used isolated mise data/cache/config directories
without activating Atlas CLI in the parent project.

The GitHub Actions workflow repeats the real installation checks on all five
platform/architecture combinations. macOS and Linux execution awaits CI after
publishing; it has not been run locally.

## References

- [MongoDB installation documentation](https://www.mongodb.com/docs/atlas/cli/current/install-atlas-cli/)
- [Official releases](https://github.com/mongodb/mongodb-atlas-cli/releases)
- [Upstream archive configuration](https://github.com/mongodb/mongodb-atlas-cli/blob/v1.59.2/build/package/.goreleaser.yml)
- [mise tool plugin documentation](https://mise.jdx.dev/tool-plugin-development.html)

## License

The plugin is MIT licensed. MongoDB Atlas CLI retains its upstream license;
the downloaded archives include MongoDB's licensing files.
