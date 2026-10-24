# Build disposable copies so no test articles ever enter the real content folder.
require 'fileutils'
require 'tmpdir'
require 'open3'
require 'rbconfig'
require 'yaml'
require 'rexml/document'

SOURCE = File.expand_path('..', __dir__)

def assert(condition, message)
  raise message unless condition
end

def build(source, destination)
  output, status = Open3.capture2e(RbConfig.ruby, Gem.bin_path('jekyll', 'jekyll'),
    'build', '--source', source, '--destination', destination, '--quiet', :chdir => source)
  assert(status.success?, "Jekyll build failed:\n#{output}")
  assert(File.exist?(File.join(destination, 'blog.html')), "No blog output: #{output} Files: #{Dir.glob(File.join(destination, '**/*')).inspect}")
end

def write_post(source, name, data)
  File.write(File.join(source, '_posts', name + '.md'),
    YAML.dump(data) + "---\n\n## A practical step\n\nListen with **curiosity**.\n\n- Ask a question\n- Make space to answer\n")
end

def xml(path)
  REXML::Document.new(File.read(path))
end

Dir.mktmpdir('refynity-blog-test-') do |tmp|
  tmp = File.realpath(tmp)
  source = File.join(tmp, 'source')
  destination = File.join(tmp, 'site')
  FileUtils.mkdir_p(source)
  Dir.children(SOURCE).each do |name|
    next if %w[.git _site .bundle vendor .jekyll-cache .jekyll-metadata .sass-cache].include?(name)
    FileUtils.cp_r(File.join(SOURCE, name), source)
  end
  FileUtils.rm_rf(File.join(source, '_posts'))
  FileUtils.mkdir_p(File.join(source, '_posts'))
  config = YAML.load_file(File.join(source, '_config.yml'))
  cms = YAML.load_file(File.join(source, '.pages.yml'))
  published_field = cms.fetch('content').first.fetch('fields').find { |f| f['name'] == 'published' }
  assert(published_field['default'] == false, 'CMS must start new articles as drafts')
  assert(config['future'] == false, 'Future articles must be excluded')

  build(source, destination)
  assert(File.read(File.join(destination, 'blog.html')).include?('Our first articles are on the way.'), 'Missing empty state')
  assert(REXML::XPath.match(xml(File.join(destination, 'feed.xml')), '//item').empty?, 'Empty feed contains articles')
  assert(!File.exist?(File.join(destination, 'docs')), 'Internal documentation must not be deployed')
  assert(!File.exist?(File.join(destination, 'tests')), 'Test source must not be deployed')
  assert(!File.exist?(File.join(destination, '.pages.yml')), 'CMS config must not be copied to the site')

  base = { 'title' => 'A & B <em>reflection</em>', 'date' => '2020-01-02', 'author' => 'Refynity',
    'description' => 'A summary with "quotes" & clarity.', 'published' => true }
  write_post(source, '2020-01-02-public-check', base)
  write_post(source, '2020-01-03-draft-check', base.merge('published' => false))
  write_post(source, '2020-01-04-default-draft', base.reject { |k, _| k == 'published' })
  write_post(source, '2099-01-01-future-check', base.merge('date' => '2099-01-01'))
  build(source, destination)
  listing = File.read(File.join(destination, 'blog.html'))
  article_path = File.join(destination, 'blog/public-check/index.html')
  assert(File.exist?(article_path), 'Published article was not generated')
  article = File.read(article_path)
  assert(listing.include?('/blog/public-check/'), 'Published article missing from blog')
  assert(!listing.include?('Our first articles are on the way.'), 'Empty state remains after publishing')
  assert(article.include?('<strong>curiosity</strong>'), 'Markdown body did not render')
  assert(article.include?('A &amp; B &lt;em&gt;reflection&lt;/em&gt;'), 'Article title was not escaped')
  assert(article.include?('href="/css/styles.css"') && article.include?('href="/blog.html"'), 'Nested article asset/navigation paths are broken')
  assert(article.include?('content="article"'), 'Article Open Graph type is missing')
  assert(article.include?('https://refynity.co/blog/public-check/'), 'Canonical article URL is wrong')
  assert(article.include?('1 min read'), 'Reading time is missing')
  %w[draft-check default-draft future-check].each do |slug|
    assert(!File.exist?(File.join(destination, 'blog', slug)), "Unpublished article leaked: #{slug}")
    assert(!listing.include?(slug), "Unpublished article listed: #{slug}")
  end
  feed = xml(File.join(destination, 'feed.xml'))
  sitemap = xml(File.join(destination, 'sitemap.xml'))
  assert(REXML::XPath.match(feed, '//item').length == 1, 'Feed must contain only published articles')
  assert(REXML::XPath.first(feed, '//item/title').text == base['title'], 'Feed title is not XML-safe')
  assert(sitemap.to_s.include?('/blog/public-check/'), 'Sitemap is missing published article')
  assert(!sitemap.to_s.match?(/draft-check|default-draft|future-check/), 'Sitemap exposes unpublished articles')

  write_post(source, '2020-01-02-public-check', base.merge('published' => false))
  build(source, destination)
  assert(!File.exist?(article_path), 'Unpublishing did not remove the article page')
  assert(!File.read(File.join(destination, 'blog.html')).include?('/blog/public-check/'), 'Unpublished article remains listed')
  assert(REXML::XPath.match(xml(File.join(destination, 'feed.xml')), '//item').empty?, 'Unpublished article remains in feed')
  assert(!File.read(File.join(destination, 'sitemap.xml')).include?('/blog/public-check/'), 'Unpublished article remains in sitemap')
end
puts 'PASS: empty blog, publishing, draft defaults, future dates, unpublishing, Markdown, escaped metadata, nested routes, sitemap, and RSS.'
