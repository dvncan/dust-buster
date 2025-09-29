# 🧹 Dust Buster

**Dust Buster** is a smart command-line tool that scans your code repositories, summarizes file types, flags large or unnecessary files, and suggests cleanup candidates — all in a safe, reviewable way.

## ✨ Features

- 📊 File type breakdown
- 🔍 Largest files and folders report
- 🧹 Flags unused or bulky files (e.g. `.dmg`, `.log`, `.zip`, `.DS_Store`)
- 🧠 Smart suggestions (e.g. `node_modules/`, `__pycache__/`)
- ✅ Optional cleanup (confirmation required)

## 🖥️ Usage

```bash
./smart_repo_scan.sh /path/to/your/repo
```

# 📦 Example Output
```bash
📊 File type summary:
25 sh
12 dmg
7 zip
3 DS_Store

📦 Top 10 largest files:
...

🧹 Suggested deletable files:
./app.dmg
./logs/debug.log
./.../.DS_Store

🗑️  Do you want to delete the suggested files above? [y/N]

[y] ✅ Cleanup done.

[n] ❌ Skipping deletion.

```
