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
