# Deploy mybotpetunia.com Landing Page

**Status:** Landing page created and ready to deploy!

**Location:** `~/mybotpetunia-landing/`

---

## Quick Deploy (2 minutes)

### Option 1: Vercel CLI (Fastest)

```bash
cd ~/mybotpetunia-landing
vercel login
# Follow the login prompts in your browser
vercel --prod
```

When asked:
- Project name: `mybotpetunia`
- Which scope: Choose your account
- Link to existing project: No
- Settings: Accept defaults

**After deployment:**
1. Go to Vercel dashboard: vercel.com/dashboard
2. Click on the mybotpetunia project
3. Go to Settings → Domains
4. Add custom domain: `mybotpetunia.com`
5. Update your DNS (if not already pointed to Vercel)

---

### Option 2: Vercel Dashboard (Visual)

1. Go to vercel.com/new
2. Upload the `~/mybotpetunia-landing` folder
3. Set project name: `mybotpetunia`
4. Deploy
5. Add custom domain `mybotpetunia.com` in project settings

---

## DNS Configuration

**If mybotpetunia.com is on Porkbun:**

Add these records:
- Type: `A`
- Host: `@`
- Answer: `76.76.21.21`

- Type: `CNAME` 
- Host: `www`
- Answer: `cname.vercel-dns.com`

---

## Files Created

```
~/mybotpetunia-landing/
├── index.html       # Landing page (ready)
├── vercel.json      # Vercel configuration (ready)
└── DEPLOY-INSTRUCTIONS.md  # This file
```

---

## What the Page Shows

- Company name: My Bot Petunia
- Tagline: AI-Powered Digital Products & Services
- Clean, professional design
- Purple gradient theme
- Mobile responsive
- Perfect for Stripe business website requirement

---

## Live URL After Deploy

- **Main:** https://mybotpetunia.com
- **Vercel:** https://mybotpetunia.vercel.app (automatic)

---

## Need Help?

The landing page is complete and ready. Just need to:
1. Run `vercel login` and authenticate
2. Run `vercel --prod` to deploy
3. Should be live in 30 seconds

Let me know if you hit any issues!
