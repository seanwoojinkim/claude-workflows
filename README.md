# Claude Workflows

A structured workflow system for Claude Code that enables systematic feature development through specialized agents and organized documentation.

## Overview

This toolkit provides a comprehensive workflow for building features with Claude Code:

- **Specialized Agents**: Five purpose-built agents for different phases of development
- **Structured Documentation**: Organized thoughts/ directory for tracking research, plans, and implementation
- **Workflow Scripts**: Automation tools for managing documentation and changelogs
- **Installation System**: Easy deployment to any project

## What's Included

### Agents (.claude/agents/)

- **codebase-researcher**: Investigates and documents existing code patterns
- **implementation-planner**: Creates detailed technical plans from requirements
- **plan-implementer**: Executes plans systematically with phase tracking
- **code-reviewer**: Reviews implementations against plan requirements
- **synthesis-teacher**: Generates learning documentation from completed features

### Workflow Scripts (hack/)

- **generate_frontmatter.sh**: Creates structured markdown files with YAML frontmatter
- **update_changelog.sh**: Maintains version-tracked changelogs
- **spec_metadata.sh**: Adds metadata to RSpec test files
- **install.sh**: Deploys workflow to target projects

### Documentation Structure (thoughts/)

```
thoughts/
├── research/              # Investigation and discovery
├── plans/                 # Feature plans and specifications
├── implementation-details/# Technical implementation notes
├── reviews/              # Code review reports
└── learning/             # Synthesis and learning documents
```

## Installation

### Quick Start

```bash
# Clone this repository
git clone https://github.com/yourusername/claude-workflows.git
cd claude-workflows

# Install to your project
./hack/install.sh /path/to/your/project
```

### Manual Installation

If you prefer to install manually:

```bash
cp -r .claude /path/to/your/project/
cp -r hack /path/to/your/project/
mkdir -p /path/to/your/project/thoughts/{research,plans,implementation-details,reviews,learning}
```

## Usage

### Basic Workflow

1. **Research**: Start with codebase-researcher to understand existing patterns
2. **Plan**: Use implementation-planner to create detailed specifications
3. **Implement**: Execute with plan-implementer, working phase by phase
4. **Review**: Review each phase with code-reviewer
5. **Learn**: Generate synthesis documentation with synthesis-teacher

### Example: Adding a New Feature

```bash
# 1. Create research document
./hack/generate_frontmatter.sh research "How Authentication Works" \
  --research-question "How does the current auth system handle sessions?"

# 2. After research, create implementation plan
./hack/generate_frontmatter.sh plans "OAuth Integration Plan" \
  --features "OAuth2 authentication" \
  --status "planning"

# 3. Implement with Claude Code
# (Use plan-implementer agent in Claude Code)

# 4. Update changelog when complete
./hack/update_changelog.sh add "Added OAuth2 authentication support"
```

## Documentation

- **[Agent Workflow](.claude/AGENT_WORKFLOW.md)**: Detailed agent usage guide
- **[Frontmatter Schema](.claude/FRONTMATTER_SCHEMA.md)**: Documentation structure reference
- **[Quick Reference](.claude/QUICK_REFERENCE.md)**: Common commands and patterns
- **[Hack Scripts](hack/README.md)**: Script documentation and examples

## Development

This workflow is designed to evolve with your needs:

- Agents can be customized by editing `.claude/agents/*.md`
- Scripts can be modified in `hack/`
- Documentation templates are controlled by frontmatter schemas

### Updating Existing Projects

```bash
# Re-run install to update
./hack/install.sh /path/to/your/project --update
```

## Philosophy

This workflow embodies several principles:

1. **Systematic Progress**: Break complex features into phases
2. **Documentation as Discovery**: Write to understand and plan
3. **Learning Through Building**: Capture insights and patterns
4. **Iteration Over Perfection**: Start simple, improve incrementally

## Version History

See [CHANGELOG.md](.claude/CHANGELOG.md) for version history and updates.

## Contributing

This is a personal workflow toolkit, but feedback and suggestions are welcome. If you find bugs or have ideas for improvements, please open an issue.

## License

MIT License - feel free to adapt and modify for your own use.
