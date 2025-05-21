# Ansible Role: systemd_unit

[![CI](https://github.com/1000Bulbs/ansible-role-systemd_unit/actions/workflows/ci.yml/badge.svg)](https://github.com/1000Bulbs/ansible-role-systemd_unit/actions/workflows/ci.yml)

This Ansible role manages the creation and lifecycle of `systemd` unit files on Linux systems. It supports defining unit files dynamically via templating, and can handle multiple unit types such as `service`, `target`, or `timer`. It ensures units are written correctly, notifies systemd to reload if changes are made, and supports integration with Molecule for testing.

---

## ✅ Requirements

- Ansible 2.13+
- Python 3.9+ (for Molecule + testinfra)
- Tested on Ubuntu 22.04+

---

## ⚙️ Role Variables

These variables can be overridden in your inventory, playbooks, or `group_vars`.

### Defaults (`defaults/main.yml`)

| Variable                       | Description                                                       | Default                                                                        |
| ------------------------------ | ----------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| `systemd_unit_name`            | Name of the systemd unit (e.g., `nginx`)                          | `null`                                                                         |
| `systemd_unit_type`            | Unit type (`service`, `target`, `timer`, etc.)                    | `null`                                                                         |
| `systemd_unit_directory`       | Directory where the unit file will be placed                      | `/etc/systemd/system`                                                          |
| `systemd_unit_file`            | Full path to the unit file                                        | `{{ systemd_unit_directory }}/{{ systemd_unit_name }}.{{ systemd_unit_type }}` |
| `systemd_unit_generic_options` | List of directives for `[Unit]` section                           | `[]`                                                                           |
| `systemd_unit_options`         | List of directives for the `[<Type>]` section (e.g., `[Service]`) | `[]`                                                                           |
| `systemd_unit_install_options` | List of directives for `[Install]` section                        | `[]`                                                                           |
| `systemd_unit_types_supported` | Valid unit types this role supports                               | `['service', 'target',   'timer']`                                             |

### Variables (`vars/main.yml`)

_No variables defined._

---

## 📦 Dependencies

None.

---

## 📥 Installing the Role

To include this role in your project using a `requirements.yml` file:

```yaml
roles:
  - name: okb.systemd_unit
    src: git@github.com:1000bulbs/ansible-role-systemd_unit.git
    scm: git
    version: master
```

Then install it with:

```bash
ansible-galaxy role install -r requirements.yml
```

---

## 💡 Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for
users too:

```yaml
- name: My Playbook
  hosts: all
  become: true
  roles:
    - role: okb.systemd_unit
```

---

## 🧪 Testing

This role uses a `Makefile` for linting and formatting, and [Molecule](https://molecule.readthedocs.io/) with
`pytest-testinfra` for integration testing.

### Run tests locally

#### Lint and Format

```bash
# Run all code quality checks
make validate

# Run linting tools manually (ruff, yamllint, ansible-lint, markdownlint-cli2)
make lint

# Run Python formatting tools manually (ruff)
make format
```

#### Integration Tests

Install dependencies

```bash
pip install -r requirements.txt
```

Run Molecule integration tests

```bash
molecule test
```

---

## 🪝 Git Hooks

This project includes [pre-commit](https://pre-commit.com/) integration via Git hooks to automatically run formatting and linting checks **before each commit**.

These hooks help catch errors early and keep the codebase consistent across contributors.

### Prerequisites

Before installing the hooks, make sure your system has:

- **Python 3.9+** with `pip` installed
- **Node.js** and `npm` (required for `markdownlint-cli2`)

You can check your versions with:

```bash
python3 --version
pip --version
node --version
npm --version
```

### Install Git Hooks

```bash
make install-hooks
```

This will:

- Install pre-commit (if not already installed)
- Register a Git hook in .git/hooks/pre-commit
- Automatically run checks like:
- Code formatting with black and isort
- Linting with ruff, yamllint, and ansible-lint

### Remove Git Hooks

```bash
make uninstall-hooks
```

This removes the Git pre-commit hook and disables automatic checks.

💡 Even with hooks uninstalled, you can still run the same checks manually with `make test`.

Why Use Git Hooks?

- Ensures consistency across contributors
- Catches syntax and style issues before they hit CI
- Prevents accidental commits of broken or misformatted files
- Integrates seamlessly with your local workflow
