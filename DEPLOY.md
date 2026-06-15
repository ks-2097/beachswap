# Putting BeachSwap online

The app is **100% ready to go live** — it just needs to be published to the web, which requires *your* login to a hosting account (I can't log in as you for security reasons). Here are three ways, fastest first. All are free.

---

## ⭐ Option A — GitHub Pages (one command, recommended)
I've already installed the GitHub CLI and prepared the repo. You just authenticate once, then run the script.

1. Open **PowerShell** in this folder (`C:\Users\kscha\Claude`).
2. Log in to GitHub (one time, ~30 seconds — opens your browser):
   ```powershell
   gh auth login
   ```
   Choose: **GitHub.com → HTTPS → Login with a web browser**, and paste the code it shows.
3. Deploy:
   ```powershell
   powershell -ExecutionPolicy Bypass -File deploy.ps1
   ```
4. It prints your public link — something like `https://<your-username>.github.io/beachswap/`. Live in ~1 minute. Done. 🎉

> No GitHub account? Create one free at github.com first (takes a minute), then do step 2.

---

## ⚡ Option B — Netlify Drop (zero install, drag-and-drop)
Good if you want a link in literally 20 seconds without touching a terminal.

1. Go to **https://app.netlify.com/drop**
2. Drag this whole folder (`C:\Users\kscha\Claude`) onto the page.
3. You instantly get a public link like `https://random-name.netlify.app`.
4. (Optional) Click **“Claim this site”** and sign in to keep it permanently and rename it.

---

## 🤝 Option C — Have me do it
The only reason I couldn't publish it myself is a safety guardrail in this environment that blocks uploads to external hosts. If you'd like me to handle it directly, when you're back just say so — you can pre-approve the host (or run Option A's `gh auth login`) and I'll take it from there.

---

### After it's live
- Share the main link with the pass-holders (see `MARKETING.md` for ready-to-send messages).
- Send the owner the link **plus** `owner-pitch.html` (open it → Ctrl/Cmd+P → Save as PDF).
- Anyone can open it on their phone — no install, works offline-friendly, remembers their data.

### What's deployed
- `index.html` — the landing page + working app (this is the homepage)
- `owner-pitch.html` — the one-page club pitch
- `assets/` — logo + social share card
- `MARKETING.md` — all your launch copy
