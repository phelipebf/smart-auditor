#!/bin/bash

set -e

echo "Security Audit Skills Installer"
echo ""

echo "Select your platform:"
echo "1) Claude Code [default]"
echo "2) Copilot CLI"
echo "3) GitHub Copilot (VSCode)"
echo "4) Gemini CLI / Codex"
echo ""
read -p "Choice [1-4] (Enter for default): " choice </dev/tty
choice="${choice:-1}"

echo ""
echo "Select install location:"
echo "1) Global (~/.claude/skills) [default]"
echo "2) Current project ($(pwd))"
echo "3) Custom path"
echo ""
read -p "Choice [1-3] (Enter for default): " location_choice </dev/tty
location_choice="${location_choice:-1}"

case $location_choice in
  1)
    INSTALL_BASE="$HOME"
    ;;
  2)
    INSTALL_BASE="$(pwd)"
    ;;
  3)
    read -p "Enter path: " custom_path </dev/tty
    INSTALL_BASE="$custom_path"
    ;;
  *)
    echo "Invalid choice"
    exit 1
    ;;
esac

SMART_AUDITOR_DIR="$INSTALL_BASE/smart-auditor"

if [ -d "$SMART_AUDITOR_DIR" ]; then
  echo "Updating existing installation at $SMART_AUDITOR_DIR..."
  (cd "$SMART_AUDITOR_DIR" && git pull --quiet)
else
  echo "Installing to $SMART_AUDITOR_DIR..."
  if ! git clone https://github.com/phelipebf/smart-auditor "$SMART_AUDITOR_DIR" > /dev/null 2>&1; then
    echo "Failed to clone repository. Check your internet connection."
    exit 1
  fi
fi

case $choice in
  1)
    echo "Installing for Claude Code..."
    mkdir -p "$INSTALL_BASE/.claude/skills/"
    cp -r "$SMART_AUDITOR_DIR/skills/"* "$INSTALL_BASE/.claude/skills/"
    echo "Skills copied to $INSTALL_BASE/.claude/skills/"
    echo ""
    echo "To start: claude"
    ;;
  2)
    echo "Installing for Copilot CLI..."
    mkdir -p "$INSTALL_BASE/.claude/skills/"
    cp -r "$SMART_AUDITOR_DIR/skills/"* "$INSTALL_BASE/.claude/skills/"
    echo "Skills copied to $INSTALL_BASE/.claude/skills/"
    echo ""
    echo "To start: copilot"
    ;;
  3)
    echo "Installing for GitHub Copilot (VSCode)..."
    mkdir -p "$INSTALL_BASE/.claude/skills/" "$INSTALL_BASE/.github/prompts/"
    cp -r "$SMART_AUDITOR_DIR/skills/"* "$INSTALL_BASE/.claude/skills/"
    cp "$SMART_AUDITOR_DIR/prompts/"*.prompt.md "$INSTALL_BASE/.github/prompts/" 2>/dev/null || true
    echo "Skills copied to $INSTALL_BASE/.claude/skills/"
    echo "Prompts copied to $INSTALL_BASE/.github/prompts/"
    echo "Use prompts with: /generate_audit_report_generic"
    ;;
  4)
    echo "Installing for Gemini CLI / Codex..."
    mkdir -p "$INSTALL_BASE/.agents/skills/"
    cp -r "$SMART_AUDITOR_DIR/skills/"* "$INSTALL_BASE/.agents/skills/"
    echo "Skills copied to $INSTALL_BASE/.agents/skills/"
    echo ""
    echo "To start: gemini"
    ;;
  *)
    echo "Invalid choice"
    exit 1
    ;;
esac

echo ""
echo "Installation complete!"