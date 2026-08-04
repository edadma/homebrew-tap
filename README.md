# Homebrew Tap

Custom Homebrew tap for apps by [edadma](https://github.com/edadma).

## Install

```
brew tap edadma/tap
```

## Available Formulae

### sysl

A ref-counted systems language that compiles through LLVM to a native executable — no garbage
collector, no borrow checker.

```
brew install edadma/tap/sysl
```

Pulls in `llvm` as a runtime dependency: sysl emits textual LLVM IR and hands it to `clang` to
assemble and link, and uses `llvm-ar` to build a library into a `.syslib`. Apple's command-line tools
ship a `clang` but no `llvm-ar`, which is why the formula does not rely on them.

**Apple silicon only for now.** Other platforms build from source — see
[sysl.sh/getting-started/installation](https://sysl.sh/getting-started/installation/).

## Available Casks

### Roamer

A cross-platform file explorer with an integrated terminal.

```
brew install --cask edadma/tap/roamer
```

**Note:** Roamer is not yet code-signed with an Apple Developer certificate. On first launch, macOS may block it. To open it:

1. Right-click (or Control-click) on **Roamer.app** in `/Applications/`
2. Select **Open** from the context menu
3. Click **Open** in the dialog

This only needs to be done once per install/upgrade. After that, Roamer will open normally.
