#!/usr/bin/env python3

import argparse
import os
import re
import subprocess
import sys


HOME = os.path.expanduser("~")
SSH_CONFIG = os.path.join(HOME, ".ssh", "config")


def run(cmd, check=True, interactive=False):
    if interactive:
        return subprocess.run(cmd, check=check)
    return subprocess.run(cmd, check=check, capture_output=True, text=True)


def ssh_copy_id(hostname):
    print(f">>> Copying SSH key to root@{hostname}...")
    run(["ssh-copy-id", f"root@{hostname}"], interactive=True)


def update_ssh_config(hostname):
    print(f">>> Updating {SSH_CONFIG} with devel entry...")
    block = (
        f"Host devel\n"
        f"    HostName {hostname}\n"
        f"    User root\n"
        f"    IdentityFile ~/.ssh/id_ed25519\n"
    )

    content = ""
    if os.path.exists(SSH_CONFIG):
        with open(SSH_CONFIG) as f:
            content = f.read()

    pattern = re.compile(
        r"Host devel\s*\n(?:[ \t]+\S.*\n)*",
        re.MULTILINE,
    )
    content = pattern.sub("", content).strip()

    content = content + "\n\n" + block if content else block

    with open(SSH_CONFIG, "w") as f:
        f.write(content + "\n")

    print(f"    Written devel -> {hostname}")


def copy_dotfiles():
    files = [
        (os.path.join(HOME, ".remote_bashrc"), "devel:/root/.bashrc"),
        (os.path.join(HOME, ".remote_gitconfig"), "devel:/root/.gitconfig"),
    ]
    for src, dst in files:
        if not os.path.exists(src):
            print(f"    WARNING: {src} not found, skipping")
            continue
        print(f">>> scp {src} {dst}")
        run(["scp", src, dst])


def kitten_ssh(hostname):
    print(f">>> Running kitten ssh root@{hostname} (login/logout)...")
    run(["kitten", "ssh", f"root@{hostname}", "exit"])


def print_remote_pubkey(hostname):
    print(">>> Fetching /root/.ssh/id_rsa.pub from remote host...")
    result = run(
        ["ssh", "devel", "cat", "/root/.ssh/id_rsa.pub"],
        check=False,
    )
    if result.returncode != 0:
        print("    Could not read remote public key. "
              "You may need to generate one with: ssh devel ssh-keygen")
        return
    print("\n========== Add this key to GitHub ==========")
    print(result.stdout.strip())
    print("=============================================\n")


def main():
    parser = argparse.ArgumentParser(
        description="Set up a remote devel instance for development."
    )
    parser.add_argument("hostname", help="Hostname or IP of the remote instance")
    args = parser.parse_args()

    hostname = args.hostname

    ssh_copy_id(hostname)
    update_ssh_config(hostname)
    copy_dotfiles()
    kitten_ssh(hostname)
    print_remote_pubkey(hostname)

    print("Done. You can now connect with: kitten ssh devel")


if __name__ == "__main__":
    main()
