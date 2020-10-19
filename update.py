import os
import re
import requests
import subprocess

REPOS = ["beevenue", "beevenue-ui"]


def get_prefix(repo):
    return f"https://api.github.com/repos/ThePadawan/{repo}/git/commits/"


def get_regex(repo):
    return re.compile(f"{get_prefix(repo)}(?P<sha>.+?)\\b")


def get_shas():
    commit_shas = {}
    for repo in REPOS:
        res = requests.get(
            f"https://api.github.com/repos/ThePadawan/{repo}/branches/master"
        )
        commit_json = res.json()
        if not "commit" in commit_json:
            raise Exception()

        commit_shas[repo] = commit_json["commit"]["sha"]
    return commit_shas


def main():
    commit_shas = get_shas()

    with open("./.gitpod.Dockerfile", "r") as dockerfile:
        file_contents = dockerfile.read()

    total_sub_count = 0
    for repo, sha in commit_shas.items():
        regex = get_regex(repo)
        (file_contents, sub_count) = regex.subn(
            f"{get_prefix(repo)}{sha}", file_contents
        )

        total_sub_count += sub_count

    env_file_path = os.environ["GITHUB_ENV"]
    with open(env_file_path, "a") as f:
        f.writelines([f"GITPOD_BEEVENUE_SUB_COUNT={total_sub_count}"])

    if total_sub_count == 0:
        return

    with open("./.gitpod.Dockerfile", "w") as dockerfile:
        dockerfile.write(file_contents)


if __name__ == "__main__":
    main()