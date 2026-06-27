# Git Workflow — Linear History

This project uses a **linear commit history on `main`**: one logical step per
commit, no long-lived branches, no merge commits. The result is a clean,
readable history that narrates the project from data acquisition to final
dashboard — which is exactly what a reviewer browsing the repo wants to see.

## Why linear (and not a branch per step)

The six notebooks are **sequential and dependent** — notebook 02 needs 01's
output, 03 needs 02's, and so on. Branches pay off when work is *independent* and
developed in parallel; here it is a straight line, so parallel branches would
only create merge pain. Notebooks also diff and merge badly in git (they are
JSON with embedded outputs), which makes a many-branch merge especially
unpleasant. A linear history avoids all of that.

## One-time setup

Run the provided setup script **once** from inside the project folder. It
initializes the repo on `main`, applies the linear-history config, and makes the
first commit:

```bash
# Windows
setup_git.bat

# macOS / Linux
bash setup_git.sh
```

## Repo configuration

The script applies these settings, which enforce a linear history:

```bash
git config pull.rebase true     # rebase instead of merge on pull
git config merge.ff only        # refuse to create merge commits
git config branch.main.mergeOptions "--ff-only"
```

## Commit convention

One commit per completed step, present-tense, prefixed by type:

```
chore: initial project scaffold
feat: 01 data acquisition & profiling
feat: 02 target engineering
feat: 03 EDA — who defaults
feat: 04 EDA — payment behavior over time
feat: 05 cleaning & risk-factor model
feat: 06 insights summary & dashboard
docs: add Tableau dashboard link and key findings
```

Common prefixes: `feat` (new analysis/feature), `fix` (correction),
`docs` (documentation), `chore` (setup/maintenance), `refactor` (restructuring).

## Keeping notebook diffs clean

Embedded cell outputs bloat diffs and the repo. Before committing a notebook,
either **Restart & Clear Output** in Jupyter, or use
[`nbstripout`](https://github.com/kynan/nbstripout):

```bash
pip install nbstripout
nbstripout --install        # registers a git filter that strips output on commit
```

(Optional — if you skip it, just clear outputs manually before committing.)

## Day-to-day flow

```bash
# after finishing a notebook / step
git add <files>
git commit -m "feat: 03 EDA — who defaults"

# if collaborating and pulling updates
git pull            # rebases, keeping history linear
```
