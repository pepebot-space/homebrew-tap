# Pepebot Homebrew Tap

Official Homebrew tap for [Pepebot](https://github.com/pepebot-space/pepebot) - Ultra-lightweight Personal AI Agent.

## Installation

```bash
# Add tap
brew tap pepebot-space/tap

# Install pepebot
brew install pepebot

# Verify installation
pepebot version
```

## Usage

### Interactive Mode

```bash
# Run setup wizard
pepebot onboard

# Start interactive chat
pepebot agent

# Check status
pepebot status
```

### Gateway Mode (Background Service)

```bash
# Start service
brew services start pepebot

# Check service status
brew services list | grep pepebot

# View logs
tail -f /usr/local/var/log/pepebot.log  # Intel Mac
tail -f /opt/homebrew/var/log/pepebot.log  # Apple Silicon

# Stop service
brew services stop pepebot
```

### One-off Commands

```bash
# Single message
pepebot agent -m "Hello!"

# Install builtin skills
pepebot skills install-builtin

# List workflows
pepebot skills list
```

## Updating

```bash
# Update Homebrew
brew update

# Upgrade pepebot
brew upgrade pepebot
```

## Uninstalling

```bash
# Stop service if running
brew services stop pepebot

# Uninstall
brew uninstall pepebot

# Remove tap (optional)
brew untap pepebot-space/tap
```

## Configuration

Configuration file: `~/.pepebot/config.json`

Workspace: `~/.pepebot/workspace/`

## Documentation

- [Main Repository](https://github.com/pepebot-space/pepebot)
- [Installation Guide](https://github.com/pepebot-space/pepebot/blob/main/docs/install.md)
- [Workflow Documentation](https://github.com/pepebot-space/pepebot/blob/main/docs/workflows.md)
- [Changelog](https://github.com/pepebot-space/pepebot/blob/main/CHANGELOG.md)

## Support

- [Issues](https://github.com/pepebot-space/pepebot/issues)
- [Discussions](https://github.com/pepebot-space/pepebot/discussions)

## License

MIT License - see [LICENSE](https://github.com/pepebot-space/pepebot/blob/main/LICENSE)

