# Notes and gotchas

<!--toc:start-->
- [Notes and gotchas](#notes-and-gotchas)
  - [NixOS](#nixos)
  - [Ruby](#ruby)
  - [Puppet](#puppet)
<!--toc:end-->

## NixOS

Language servers, formatters and other tools for Nix should be installed manually without Mason since they will mostly be used on a NixOS system anyway.

Some programs, such as `gopls` and `marksman`, for some reason don't work on NixOS even if no libraries seem to be missing. Mason should skip downloading those programs on a NixOS system and they should be installed as a Nix package.

## Ruby

Mason only provides wrappers over `solargraph` and `rubocop`. They must also be installed manually as gems. Afterwards, only `solargraph` should be installed through Mason because if both are installed then some diagnostics are duplicated.

## Puppet

Follow these instructions: https://github.com/puppetlabs/puppet-editor-services#setting-up-editor-services-for-development

Then install the following gems for extra linting and formatting:

```bash
gem install puppet-lint puppet-lint-strict_indent-check puppet-lint-manifest_whitespace-check puppet-lint-unquoted_string-check puppet-lint-leading_zero-check puppet-lint-absolute_classname-check puppet-lint-trailing_comma-check puppet-lint-file_ensure-check puppet-lint-legacy_facts-check
```

## Protobuf

Until `pbls` or another language server is added to Mason and Nix, ensure `protoc` is in your $PATH and install `pbls` from `cargo install --git https://git.sr.ht/~rrc/pbls`
