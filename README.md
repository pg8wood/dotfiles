# Dotfiles

Personal macOS setup scripts and shell config to make life more convenient.

## Fresh-Machine Quick Start

You can clone this repo with no SSH setup because it is public.

On a brand-new Mac, run:

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/pg8wood/dotfiles/main/bootstrap.sh)"
```

What this does:
- Installs Xcode Command Line Tools (if missing)
- Installs Homebrew (if missing)
- Clones this repo over HTTPS to `~/Developer/dotfiles`
- Runs `install.sh`

If CLT is missing, macOS will show an install dialog and bootstrap will wait for it to finish.

## GitHub + SSH Automation

`install.sh` can now optionally:
- Authenticate GitHub CLI (`gh auth login`)
- Generate an SSH key
- Upload the key to GitHub (`gh ssh-key add`)
- Switch GitHub remotes to SSH

## Private Identity Config

Tracked `.gitconfig` now includes:

```ini
[include]
    path = ~/.gitconfig_private
```

So your git name/email/signing key stay private in `~/.gitconfig_private` and out of this public repo.

`install.sh` will create that file for you if it does not exist.
