# Add Application Skill

Automate adding a new application to the Homebrew tap.

## Usage

When a user requests to add a new application (cask or formula), follow these steps:

## Steps

### 1. Gather Application Information

Ask the user for:

- Application name (lowercase, no spaces)
- Type: cask or formula
- API URL for release info (GitHub API or other)
- URL template for downloads (use VERSION placeholder)
- For betterbird-style apps with dual architectures, get both `url_template_arm64` and `url_template_intel`

### 2. Create the Cask/Formula File

**For Casks:** Create `Casks/<app-name>.rb`

Use this template for standard GitHub releases:

```ruby
cask "<app-name>" do
  version "<version>"
  sha256 "<sha256>"

  url "<download-url>",
      verified: "<domain>"
  name "<App Name>"
  desc "<Description>"
  homepage "<homepage-url>"

  app "<app-name>.app"
  zap trash: [
    "~/Library/Application Support/<app-name>",
    "~/Library/Caches/<app-name>",
    "~/Library/Preferences/<app-name>.plist",
  ]
end
```

For betterbird-style (dual architecture):

```ruby
cask "<app-name>" do
  version "<version>"
  sha256 arm: "<sha256-arm64>",
         intel: "<sha256-intel>"

  url arm: "<arm64-url>",
      intel: "<intel-url>",
      verified: "<domain>"
  name "<App Name>"
  desc "<Description>"
  homepage "<homepage-url>"

  app "<app-name>.app"
  zap trash: [
    "~/Library/Application Support/<app-name>",
    "~/Library/Caches/<app-name>",
    "~/Library/Preferences/<app-name>.plist>",
  ]
end
```

**For Formulas:** Create `Formula/<app-name>.rb`

### 3. Update Workflow File

Edit `.github/workflows/update-casks.yml` and add a new entry to the matrix `include` section:

```yaml
- name: <app-name>
  api_url: "<api-url>"
  file: Casks/<app-name>.rb
  url_template: "<url-template-with-VERSION>"
```

For dual architecture:

```yaml
- name: <app-name>
  api_url: "<api-url>"
  file: Casks/<app-name>.rb
  url_template_arm64: "<arm64-url-template>"
  url_template_intel: "<intel-url-template>"
```

### 4. Update versions.json

Add the new app to `versions.json`:

```json
{
  "existing-app": "version",
  "<app-name>": "<initial-version>"
}
```

### 5. Update README.md

Add a new row to the README.md table:

```markdown
| <app-name> | ![](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fremusa%2Fhomebrew-tap%2Fmaster%2Fversions.json&query=%24.<app-name>&label=<app-name>) |
```

### 6. Verify the App (Optional)

Run `brew audit --new-cask Casks/<app-name>.rb` to verify the cask is valid.

### 7. Commit Changes

Commit all changes with a message like:

```
Add <app-name> to tap
```

## Example

When user says "add firefox to the tap":

1. Ask for API URL: `https://api.github.com/repos/mozilla/firefox/releases/latest`
2. Ask for URL template: `https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US`
3. Create `Casks/firefox.rb`
4. Add to workflow matrix
5. Add to versions.json with initial version
6. Add to README.md table
7. Commit changes

## Gotchas when committing / pushing this repo

- **Homebrew here is nix-store managed.** `brew audit` / `brew style` can fail with `EACCES`
  under `/nix/store/.../Library/Homebrew/...` (lefthook's `style` step is disabled for this
  reason). Validate a cask with `ruby -c Casks/<name>.rb`, the `verify-cask-shas.py` parser,
  and a live `curl -I` of the asset URL instead.
- **Editing from a git worktree.** The `commit-msg` hook reads `.git/COMMIT_EDITMSG`, but in a
  linked worktree `.git` is a *file* (gitdir pointer), so the hook sees an empty message and
  rejects. Fix **without** `--no-verify`:
  ```sh
  GITDIR=$(sed 's/^gitdir: //' .git); cp .git /tmp/bak
  rm .git; ln -s "$GITDIR" .git
  git commit -m "feat(<name>): add to tap"
  rm .git; cp /tmp/bak .git   # restore
  ```
- **Pushing a new branch to GitHub.** The global pre-push guard only allows
  `@users.noreply.github.com` identities, and for a brand-new ref it checks the *entire*
  history — which includes this repo's `actions@github.com` CI commits, so the push is blocked.
  Seed the remote ref at `origin/master` first, then push:
  ```sh
  gh api repos/remusa/homebrew-tap/git/refs \
    -f ref=refs/heads/<branch> -f sha=$(git rev-parse origin/master)
  git push origin <branch>   # range is now just your commit(s)
  ```
  Never `--no-verify` / `LEFTHOOK=0`.
- **Consumption is pinned.** The tap is used on the darwin hosts as a flake input
  (`remusa-homebrew-tap`, nix-homebrew with `mutableTaps = false`), so pushing a cask does not
  make it installable by itself — the homelab repo must bump the input
  (`nix flake update remusa-homebrew-tap`) and rebuild.
