# Managing the Refynity blog

The blog uses Jekyll, which GitHub Pages builds automatically from main. Articles are Markdown files in `_posts`; layouts generate the article pages, blog cards, sitemap entries, and RSS feed. No articles are included in this change.

## One-time editor connection

1. After this pull request is merged, open https://refynity.co/admin/ (or https://app.pagescms.org/).
2. Sign in with GitHub and install the Pages CMS GitHub App for **nour-tarabein/refynity-site**. The repository owner must grant this access. No access tokens are stored in the site.
3. Select this repository and the **main** branch. The editor reads `.pages.yml` and shows **Blog posts** and image uploads. On the development branch, choose **website-suggestions** to inspect its configuration; saving there does not publish the live site.

## Write, save, and publish

- Choose **Blog posts → New**. Enter a title, publication date, author, short summary, and article body. The rich-text editor supports headings, lists, links, and images. A cover image is optional; add a descriptive alt text when using one.
- Leave **Publish on the website** off to save a draft. Drafts are omitted from generated article pages, listing, sitemap, and feed.
- When ready, turn **Publish on the website** on and save. On main, the GitHub Pages build publishes the article and updates the listing, sitemap, and RSS automatically.
- To unpublish, turn the switch off and save. The next build removes the article from the generated site. To delete, use the editor's delete action. Edit an existing post and save to update it.
- Choose an appropriate publication date. Future-dated posts stay hidden until a site rebuild on or after that date. There is no timed scheduler; use today's date for immediate publishing.
- Keep a post's filename unchanged after publication to preserve its URL. It is generated from the creation date and title; changing the display title later does not require renaming the file.

Drafts are not confidential: the repository is public, so Markdown source, uploaded images, and Git history can be read even when a draft isn't on the website. Do not save sensitive material here.

## Preview locally

Requires Ruby 2.7+ (Ruby 3 recommended) and Bundler:

```sh
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 8123
```

Open http://127.0.0.1:8123/blog.html or /admin/. A plain Python HTTP server cannot render Jekyll templates. For local-only draft previews, add `--unpublished`; never deploy that build. The normal build is `bundle exec jekyll build`.

## Without the visual editor

Add `_posts/YYYY-MM-DD-your-title.md` with YAML front matter: `title`, `date` (YYYY-MM-DD), `published` (true or false), `author`, `description`, and optional `image` and `image_alt`. Add Markdown below the closing front-matter delimiter. Omitted `published` defaults to false. The `post` layout is assigned automatically.

## Verification

`bundle exec ruby tests/blog_system_test.rb` builds isolated fixture copies with test posts (outside the repository source) to verify publishing, drafts, future dates, unpublishing, metadata escaping, feed, sitemap, and article layout. Fixture posts are never committed or published. CI runs the same check on pull requests and main.
