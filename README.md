# Homebrew Tap

Custom Homebrew tap for apps by [edadma](https://github.com/edadma).

## Install

```
brew tap edadma/tap
```

Homebrew asks you to trust a third-party tap before it will load anything from it:

```
brew trust edadma/tap
```

## Available Formulae

### texish

A TeX-style typesetting engine that renders documents to PDF — Knuth–Plass line breaking, an
OpenType `MATH` table for mathematics, and complex-script shaping for Hebrew, Arabic, the Indic
scripts and CJK.

```
brew install edadma/tap/texish
```

Installs the prebuilt binary rather than building from source, and pulls in `cairo`, `freetype` and
`jpeg-turbo`, which it links against. The formula also installs the font catalogue and the packages
into `share/texish`; texish finds that tree by walking up from its own executable, so there is no
wrapper script and no environment variable to set.

macOS on Apple silicon, and Linux on x86_64 and arm64. Other platforms build from source — see
[texish.edadma.dev/getting-started/installation](https://texish.edadma.dev/getting-started/installation/).

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

## Elsewhere

**sysl** used to live here and does not any more — it has its own tap:

```
brew tap sysl-lang/tap
brew install sysl-lang/tap/sysl
```
