# Installation Guide

This guide covers installing the Claude Workflows toolkit into your projects.

## Prerequisites

- A project where you want to use Claude Code
- Git (optional, but recommended)
- Bash shell

## Installation Methods

### Method 1: Using the Install Script (Recommended)

The install script handles everything automatically:

```bash
# Clone the toolkit
git clone https://github.com/yourusername/claude-workflows.git
cd claude-workflows

# Install to your project
./hack/install.sh /path/to/your/project
```

**What the script does:**
1. Copies `.claude/` directory with all agents
2. Copies `hack/` workflow scripts
3. Creates `thoughts/` directory structure
4. Updates `.gitignore` (if it exists)
5. Makes scripts executable

### Method 2: Manual Installation

If you prefer manual control:

```bash
# 1. Copy agents and documentation
cp -r .claude /path/to/your/project/

# 2. Copy workflow scripts
mkdir -p /path/to/your/project/hack
cp hack/*.sh /path/to/your/project/hack/
cp hack/README.md /path/to/your/project/hack/
chmod +x /path/to/your/project/hack/*.sh

# 3. Create thoughts directory structure
mkdir -p /path/to/your/project/thoughts/{research,plans,implementation-details,reviews,learning}
touch /path/to/your/project/thoughts/*/.gitkeep

# 4. Update .gitignore
cat >> /path/to/your/project/.gitignore << 'EOF'

# Claude Code workflow - keep directory structure but ignore documents
thoughts/**/*.md
!thoughts/**/.gitkeep
EOF
```

## Updating Existing Installation

To update a project that already has the workflow:

```bash
./hack/install.sh /path/to/your/project --update
```

The update flag:
- Backs up existing `.claude/` to `.claude.backup/`
- Overwrites workflow scripts with latest versions
- Preserves your `thoughts/` documents

## Post-Installation

### 1. Restart Claude Code

For Claude Code to recognize the new agents:

```bash
cd /path/to/your/project
# Restart your Claude Code session
```

### 2. Verify Installation

Check that everything is in place:

```bash
cd /path/to/your/project

# Should see agents
ls .claude/agents/

# Should see scripts
ls hack/

# Should see thoughts structure
ls thoughts/
```

### 3. Test the Workflow

Create a test research document:

```bash
./hack/generate_frontmatter.sh research "Test Research" \
  --research-question "How does feature X work?"
```

This should create `thoughts/research/YYYY-MM-DD-test-research.md`.

## Configuration

### Customizing Agents

Agents are markdown files in `.claude/agents/`. To customize:

```bash
# Edit an agent
vim .claude/agents/implementation-planner.md
```

Changes take effect on next Claude Code restart.

### Customizing Scripts

Workflow scripts are in `hack/`:

```bash
# View available scripts
ls hack/*.sh

# Edit a script
vim hack/generate_frontmatter.sh
```

### Directory Structure

You can modify the `thoughts/` structure:

```bash
# Add a new category
mkdir thoughts/experiments
touch thoughts/experiments/.gitkeep

# Update .gitignore if needed
```

## Troubleshooting

### Agents Not Appearing

**Problem:** Claude Code doesn't show the new agents

**Solution:** Restart Claude Code completely and navigate to your project directory

### Script Permission Denied

**Problem:** `./hack/generate_frontmatter.sh: Permission denied`

**Solution:**
```bash
chmod +x hack/*.sh
```

### .gitignore Conflicts

**Problem:** thoughts/ patterns conflict with existing .gitignore

**Solution:** Manually merge the patterns or adjust to fit your project's conventions

## Uninstallation

To remove the workflow:

```bash
cd /path/to/your/project

# Remove agents
rm -rf .claude/

# Remove scripts
rm -rf hack/

# Remove thoughts (WARNING: deletes all documents)
rm -rf thoughts/

# Clean up .gitignore manually
vim .gitignore
```

## Next Steps

After installation:

1. Read [.claude/AGENT_WORKFLOW.md](.claude/AGENT_WORKFLOW.md) for workflow overview
2. Check [.claude/QUICK_REFERENCE.md](.claude/QUICK_REFERENCE.md) for common commands
3. Try the workflow on a small feature
4. Customize to fit your team's needs

## Getting Help

- Check the main [README.md](README.md) for overview
- Review [hack/README.md](hack/README.md) for script details
- Open an issue for bugs or questions
