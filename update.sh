# 1. find occurrences
grep -RIn --line-number --exclude-dir=.git "osagent" .

# 2. git rename script (preserve history)
git mv osagent osagent
chmod +x osagent
perl -pi.bak -e 's/\bagentctl\b/osagent/g' osagent

# 3. update installer + local setup + README
perl -pi.bak -e 's/\bagentctl\b/osagent/g' install.sh setup_local.sh README.md

# 4. search & update remaining files (carefully review diffs)
grep -RIn --line-number --exclude-dir=.git "osagent" . | cut -d: -f1 | sort -u | xargs -I{} perl -pi.bak -e 's/\bagentctl\b/osagent/g' {}

# 5. commit
git add -A
git commit -m "Rename CLI: osagent -> osagent"

# 6. verify
./osagent --help
grep -RIn --line-number --exclude-dir=.git "osagent" .

