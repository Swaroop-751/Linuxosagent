# 🚀 GenAI Linux Agent

> **An intelligent, autonomous Linux operator powered by Google Gemini AI**

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.68+-green.svg)](https://fastapi.tiangolo.com)
[![Gemini](https://img.shields.io/badge/Gemini-2.5--Flash-orange.svg)](https://ai.google.dev/gemini)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## ✨ Features

- **🤖 AI-Powered**: Uses Google Gemini to understand natural language requests
- **💬 Chat Memory**: Remembers conversation context across sessions
- **🔒 Safe Execution**: Policy-based command validation and approval workflow
- **🌐 Cross-Distro**: Works on RHEL, Ubuntu, Debian, SUSE, and more
- **📱 Beautiful CLI**: Attractive, colorized interface with progress indicators
- **🔍 Comprehensive Logging**: Full audit trail of all operations
- **⚡ Fast**: Lightweight FastAPI backend with minimal overhead

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   osagent      │    │   agentd         │    │   Gemini AI     │
│   (CLI)         │◄──►│   (FastAPI)      │◄──►│   (LLM)         │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌──────────────────┐
                       │   Policy Engine  │
                       │   + Chat Memory  │
                       └──────────────────┘
```

## 🚀 Quick Start

### 1. Prerequisites

- Linux system (RHEL 9+, Ubuntu 20.04+, Debian 11+, etc.)
- Python 3.8+
- `jq` command-line tool
- Google Gemini API key

### 2. Installation

```bash
# Clone the repository
git clone <your-repo-url>
cd genai-agent

# Set your Gemini API key
echo "GEMINI_API_KEY=your_api_key_here" > .env

# Run installer as root
sudo bash install.sh
```

### 3. Usage

```bash
# Basic commands
osagent "show system status"
osagent "install nginx and start it"
osagent "list running containers"
osagent "check disk usage"

# With specific role
osagent "restart httpd service" admin
```

## 📁 Project Structure

```
genai-agent/
├── app/                    # Python application
│   ├── __init__.py
│   ├── main.py            # FastAPI server
│   ├── agent_core.py      # Core logic & LLM integration
│   ├── llm_gemini.py      # Gemini API wrapper
│   ├── policy.py          # Security policy engine
│   ├── state.py           # Chat memory & state management
│   └── audit.py           # Audit logging
├── config.yaml            # Configuration
├── policy.yaml            # Security policies
├── install.sh             # Installation script
├── osagent               # CLI client
├── .env                   # Environment variables
└── README.md              # This file
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the project root:

```bash
GEMINI_API_KEY=your_gemini_api_key_here
GEMINI_MODEL=gemini-2.5-flash
```

### Policy Configuration

Edit `policy.yaml` to customize security rules:

```yaml
safety:
  blocked_patterns:
    - "rm -rf /"
    - "mkfs"
    - ":(){ :|:& };:"  # fork bomb
  max_cmd_length: 1000

roles:
  viewer:
    require_approval: true
  operator:
    require_approval: true
  admin:
    require_approval: false
```

## 🛡️ Security Features

- **Command Validation**: All commands are validated against policy rules
- **Approval Workflow**: Manual approval required by default
- **Audit Logging**: Complete record of all operations
- **Role-Based Access**: Different permission levels for different users
- **Safe Execution**: Blocked dangerous command patterns

## 📊 Examples

### System Management
```bash
# Service operations
osagent "start nginx service"
osagent "enable and start httpd"
osagent "restart crond service"

# Package management
osagent "install git and vim"
osagent "remove old packages"
osagent "update system packages"
```

### Monitoring & Diagnostics
```bash
# System status
osagent "check system load and memory"
osagent "show disk usage and free space"
osagent "list network connections"

# Log analysis
osagent "show recent SELinux denials"
osagent "check system logs for errors"
osagent "grep firewall logs"
```

### Container Operations
```bash
# Docker/Podman
osagent "pull nginx image"
osagent "run container on port 8080"
osagent "list running containers"
osagent "show container logs"
```

## 🔍 Troubleshooting

### Service Issues
```bash
# Check service status
sudo systemctl status genai-agent

# View logs
sudo journalctl -u genai-agent -f

# Restart service
sudo systemctl restart genai-agent
```

### Common Problems

1. **Permission Denied**: Ensure the service is running as root or has proper sudo access
2. **Gemini API Errors**: Verify your API key and internet connectivity
3. **Command Failures**: Check the command output for specific error messages

## 🧪 Testing

Test the agent with various commands:

```bash
# Test basic functionality
osagent "show OS version"
osagent "list current directory"

# Test system operations
osagent "check available memory"
osagent "show network interfaces"

# Test package operations
osagent "check if git is installed"
osagent "show package manager info"
```

## 📈 Performance

- **Response Time**: Typically 2-5 seconds for command generation
- **Memory Usage**: ~50-100MB for the Python service
- **CPU Usage**: Minimal during idle, spikes during LLM calls
- **Storage**: ~10-50MB for logs and state files
