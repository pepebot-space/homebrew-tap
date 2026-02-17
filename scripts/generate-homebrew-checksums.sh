#!/bin/bash
# Generate SHA256 checksums for Homebrew formula
# Usage: ./generate-homebrew-checksums.sh v0.4.0

set -e

VERSION=${1:-latest}
REPO="pepebot-space/pepebot"

if [ "$VERSION" = "latest" ]; then
    echo "Fetching latest version..."
    VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
fi

echo "Generating checksums for version: $VERSION"
echo ""

# Define platforms
declare -A platforms=(
    ["darwin-amd64"]="macOS Intel"
    ["darwin-arm64"]="macOS Apple Silicon"
    ["linux-amd64"]="Linux x86_64"
    ["linux-arm64"]="Linux ARM64"
    ["linux-armv7"]="Linux ARMv7"
)

# Download and calculate checksums
for platform in "${!platforms[@]}"; do
    filename="pepebot-${platform}.tar.gz"
    url="https://github.com/${REPO}/releases/download/${VERSION}/${filename}"

    echo "📦 ${platforms[$platform]} (${platform})"
    echo "   Downloading: $url"

    # Download file
    if curl -fsSL "$url" -o "/tmp/${filename}"; then
        # Calculate SHA256
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sha256=$(shasum -a 256 "/tmp/${filename}" | awk '{print $1}')
        else
            sha256=$(sha256sum "/tmp/${filename}" | awk '{print $1}')
        fi

        echo "   SHA256: $sha256"
        echo ""

        # Clean up
        rm -f "/tmp/${filename}"
    else
        echo "   ⚠️  Failed to download"
        echo ""
    fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Copy these SHA256 values to Formula/pepebot.rb in the homebrew-tap repo"
echo "Update the version number and checksums, then commit and push."
echo ""
echo "Repository: https://github.com/${REPO/pepebot/homebrew-tap}"
