# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added a Lua mise plugin for installing the official MongoDB Atlas CLI archives on Windows x64, macOS x64/ARM64, and Linux x64/ARM64.
- Added stable release discovery, published SHA-256 checksum verification, and `atlas` executable PATH configuration.
- Added installation documentation and a GitHub Actions installation matrix for all five supported platforms.
- Added the MIT license and repository line-ending and temporary-file rules.
- Added a repository-local agent skill for using `atlas` through mise and distinguishing it from Ariga Atlas.

### Changed

- Made direct GitHub installation and project activation the primary setup instructions.
