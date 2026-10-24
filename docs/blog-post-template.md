# Publishing a Refynity blog article

The website uses static HTML. There is no build step or content management system.

1. Get the article text and byline approved by Shauna. Verify any research claims and link to the original sources.
2. Copy blog.html to a descriptive root-level filename such as leadership-conversations.html. Keep the shared header, footer, stylesheet, scripts, and active Blog navigation item.
3. Set a unique title, meta description, canonical URL, og:url, og:title, og:description, and og:type="article". Use the actual publication date rather than an estimated date.
4. Replace the content inside main with the approved article. Use one h1, meaningful h2 headings, paragraphs, and a visible byline and publication date. A container with class "container container--narrow" keeps text readable. Give images descriptive alt text and confirm permission to use them.
5. Add a link back to blog.html. Add a real article card on blog.html linking to the article; remove the “Our first articles are on the way” empty state when the first article is published.
6. Add the article's canonical URL to sitemap.xml. Keep robots.txt pointed at that sitemap.
7. Preview both pages on mobile and desktop; check links and metadata. Commit and review before merging to main, which deploys to the live GitHub Pages site.

Suggested article outline (planning only; not an approved article):

- Title: a specific leadership question the reader needs answered
- Introduction: the real situation and why it matters
- Practical steps: a few clear actions and realistic examples
- Reflection: one question to try with the team this week
- Next step: a relevant Refynity service or invitation to talk
