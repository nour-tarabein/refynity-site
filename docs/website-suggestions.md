# Website suggestions: implementation and remaining inputs

## Implemented for review

- New homepage pain-points section based on pitch deck slide 2, with all six problems.
- Existing leadership statistics moved above “What is Refynity.” The existing scenario cards remain as examples further down the page.
- Two training reviews supplied as screenshots are published verbatim on the homepage: Brenda, Training Director; and Delfina, Teacher. Their individual five-star ratings are reproduced from the screenshots. The earlier four PDF versions remain in docs/testimonials.html, excluded from the live build.
- Responsive Blog page in every page's header and footer. It has an honest empty state, with no fabricated articles, authors, dates, or case studies.
- Canonical URLs, Open Graph URLs, sitemap.xml, and robots.txt.
- Corrected the shared mobile navigation's missing aria-controls target.

## Testimonial sources

The user supplied two review screenshots after requesting LinkedIn testimonials. Use only the quote text, first names, roles, and individual ratings visible in those screenshots. Do not add surnames or companies from other sources. The remaining PDF testimonials stay excluded pending approval. Keep private source documents out of this public repository.

## Inputs still needed

1. **Portrait:** provide a high-resolution, approved portrait or arrange a branded photoshoot. Replace assets/img/shauna.jpg; the homepage and About page both use it. A portrait crop works best. Enlarging the existing image cannot recover missing detail.
2. **Blog content:** supply approved articles. The Jekyll/Pages CMS blog system is ready; follow docs/blog-post-template.md to connect the editor and publish. Listing, sitemap, and RSS update automatically. No posts are included.
3. **Google Business Profile/account:** a business owner needs to provide the business account, business details, and complete Google's verification. No Google account or profile was created as part of repository work.
4. **Analytics:** no analytics tag was found in this repository. A Google Analytics property/measurement ID and the desired consent configuration are needed before tracking can be connected. No tracking code is enabled by this change.
5. **Research figures:** the existing homepage and Services figures remain unchanged. The deck's later slide says 76% for manager impact, while the website says 70%; verify the primary research before changing this claim. This implementation uses slide 2 for the new section only.

## Verification

Preview with `bundle exec jekyll serve --host 127.0.0.1 --port 8123` and open http://127.0.0.1:8123. Check all five pages on desktop and mobile, open and close the mobile menu, follow the Blog links, and inspect the new homepage sections.
