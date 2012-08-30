$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pdf_maker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pdf_maker"
  s.version     = PdfMaker::VERSION
  s.authors     = ["Sean Behan"]
  s.email       = ["inbox@seanbehan.com"]
  s.homepage    = "http://github.com/gristmill/pdf_maker"
  s.summary     = "PdfMaker builds PDFs from Rails templates."
  s.description = "Turn your Rails actions/views into PDFs without a web browser"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "pdfkit", "~> 0.5.2"
  s.add_dependency "sprockets", "~> 2.1"
  s.add_dependency "sass", "~> 3.1"
  s.add_dependency 'wkhtmltopdf-binary', "~> 0.9.9.1"
  s.add_dependency 'sass-rails',   '~> 3.2'
  s.add_dependency 'coffee-rails', '~> 3.2'
  s.add_dependency 'therubyracer', '~> 0.9'
  s.add_dependency 'uglifier', '>= 1.0'
  s.add_development_dependency "sqlite3"
end
