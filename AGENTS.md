# AGENTS.md - Instructions for Automated Agents

When adding a new application to this Homebrew tap, follow this workflow:

## Required Changes

When adding application `<app-name>`:

### 1. Create the Cask or Formula

**For Casks:** Create `Casks/<app-name>.rb`

- Use appropriate template from `.opencode/skills/add-app.md`
- Set initial version and sha256 (use placeholder if unknown)

**For Formulas:** Create `Formula/<app-name>.rb`

### 2. Update Workflow

Edit `.github/workflows/update-casks.yml`:

- Add entry to `matrix.include` section with:
  - `name`: application name
  - `api_url`: release API endpoint
  - `file`: path to cask/formula file
  - `url_template`: download URL with VERSION placeholder
  - For dual-arch apps: `url_template_arm64` and `url_template_intel`

### 3. Update versions.json

Add entry to `versions.json`:

```json
{
  "<app-name>": "<initial-version>"
}
```

### 4. Update README.md

Add row to the Casks table:

```markdown
| <app-name> | ![](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fremusa%2Fhomebrew-tap%2Fmaster%2Fversions.json&query=%24.<app-name>&label=<app-name>) |
```

### 5. Commit

Commit all changes:

```
git add Casks/<app-name>.rb .github/workflows/update-casks.yml versions.json README.md
git commit -m "Add <app-name> to tap"
```

## Important Notes

- Version placeholders should be actual versions when possible
- SHA256 can be computed after cask creation using `brew fetch --cask <app-name>`
- Betterbird uses dual architecture (arm64 + intel) - see existing cask for pattern
- All four files must be updated together for consistency
