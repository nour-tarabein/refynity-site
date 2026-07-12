# Refynity — Website (Front End)

A fast, deployable **static site** for Refynity — leadership & management training for growth‑stage companies. No build step, no framework, no backend required. Just HTML, CSS, and a little vanilla JavaScript.

Built to the brand bible and the website layout brief: navy `#2F313F` · burgundy `#5A1826` · sand `#CAC2B5` · sage `#92A297`, with an elegant serif display face and the interlocking‑infinity mark (Reflection · Refinement · Infinity).

---

## Pages

| File | Page | Highlights |
|---|---|---|
| `index.html` | Home | Hero (wordmark + founder photo), what‑is‑Refynity, 3 scenario cards, 2 services, methodology + infinity spine, retention stats, brand statement, CTA |
| `about.html` | About | The why, founder credibility, the three pillars, brand values, who we serve |
| `services.html` | Services | 3‑Day Training Series (with day‑by‑day breakdown), 1:1 Coaching, how we work, ROI stats |
| `contact.html` | Contact | Contact details + working front‑end form, member note |

Shared across all pages: top social bar, sticky nav, member sign‑in stub (modal), footer.

## Structure

```
mark/
├── index.html · about.html · services.html · contact.html
├── css/styles.css        # the entire design system — single source of truth
├── js/main.js            # nav, scroll reveals, form handling, member modal
├── assets/
│   ├── favicon.svg       # navy tile + infinity mark
│   └── mark.svg          # standalone infinity/monogram mark
└── README.md
```

## Preview locally

```bash
cd mark
python3 -m http.server 8123
# open http://127.0.0.1:8123
```

## Deploy (pick one — all free)

- **Netlify / Vercel:** drag the `mark/` folder onto the dashboard, or connect the repo. No settings needed.
- **GitHub Pages:** push to a repo → Settings → Pages → deploy from branch root.
- **Cloudflare Pages / any static host:** upload the folder as‑is.

Point your `refynity.co` domain at whichever host you choose.

---

## ⚠️ Before you launch — swap these placeholders

1. **Founder photo.** ✅ Done — Shauna's photo (`assets/img/shauna.jpg`) is now in the hero and About page. To swap it later, just replace that file (a vertical/portrait crop looks best).
2. **Section imagery.** All photos are free **Unsplash** images loaded from their CDN (`images.unsplash.com/...`). They're licensed for use, but replace them with your own brand photography when you have it — just change the `src` URLs (or drop files into `assets/img/` and point to them for a fully self‑contained site).
3. **Fonts.** The brand fonts are **The Seasons** (display) and **HK Grotesk** (body), which are paid/licensed. The site currently uses close free stand‑ins from Google Fonts — **Cormorant Garamond** and **Manrope**. If you have web licenses for the real fonts, self‑host them and update the `<link>` + the `--display` / `--body` variables in `css/styles.css`.
4. **Email address.** ✅ Done — `shauna@refynity.co` is used in the footer, contact page, and contact form.
5. **Statistics.** The retention/ROI figures cite widely reported Gallup research. **Verify the current published numbers** before going live (each has a visible "please confirm" note in the source).
6. **Contact form.** ✅ Wired to **FormSubmit** (free, no account) → delivers to `shauna@refynity.co`. **One-time setup:** the first submission triggers a "Confirm your email" message from FormSubmit to Shauna's inbox — she clicks **Activate** once, and from then on every inquiry is delivered. To switch providers later (e.g. Formspree or a custom backend), change the endpoint in `js/main.js` and the `action` on the form in `contact.html`.
7. **Member sign‑in.** This is intentionally a stub (a "coming soon" modal), per the brief — no members yet. The real portal is a separate backend build we can scope when you're ready.

## Brand tokens (quick reference)

All defined at the top of `css/styles.css` under `:root`:

- Colors: `--ink #2F313F` · `--burgundy #5A1826` · `--sand #CAC2B5` · `--sage #92A297` · `--paper #F7F5F0`
- Display font: `--display` (Cormorant Garamond → The Seasons)
- Body font: `--body` (Manrope → HK Grotesk)

## Accessibility & quality

Responsive down to mobile (tested at 375px), keyboard‑focusable with visible focus rings, a skip link, `prefers-reduced-motion` respected, and semantic landmarks. No console errors.

## Social links (wired)

- Instagram — https://www.instagram.com/refynity
- LinkedIn — https://www.linkedin.com/in/shauna-dabiri-far-1b628b406
- Facebook — https://www.facebook.com/profile.php?id=61590279253146

---

*Note: the brand board carried a leftover template tagline ("Discover the Power of Natural Ingredients") that belongs to a different template — it was omitted. The site uses your real taglines from the brand bible: "Enter with curiosity. Commit to evolution. Remove the ceiling." and "Better leaders build stronger teams."*
