require 'pdfkit'
require 'tempfile'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

module PdfMaker
  class Base < AbstractController::Base
    include AbstractController::Rendering
    include AbstractController::Layouts
    include AbstractController::Helpers
    include AbstractController::AssetPaths
    include ActionView::Helpers::OutputSafetyHelper
    include ActionView::Helpers::TextHelper

    self.view_paths = "."

    attr_accessor :pdf

    helper_method :pdf_assets

    def pdf_assets
      env = Sprockets::Environment.new

      Rails.application.assets.paths.each { |asset_path| env.append_path asset_path }

      x = "<style>#{env['application.css']}</style> <script>#{env['application.js']}</script>"
      puts x
      raw(x)
    end

    # PDFMaker.new(view: 'users/profile', locals: {}, ivars: {user: User.find(pk)}, layout: 'application')
    def initialize(*options)
      @options = options.extract_options!

      @view = @options[:view]

      (@options[:ivars] || {}).each { |k,v| instance_variable_set("@#{k}", v)}

      @pdf = PDFKit.new(render(@view, @options))
    end

    def to_file(path)
      @pdf.to_file(path)
    end
  end
end
