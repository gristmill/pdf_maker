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

    attr_accessor :pdf, :view

    helper_method :pdf_maker_assets_tag

    def initialize(&block)
      instance_eval(&block)
      @pdf = PDFKit.new(render(@renders, options))
    end

    def layout(layout=nil)
      return @layout if defined?(@layout)
      @layout = layout
    end
    
    def options
      @options ||= {}
      @options.merge({layout: layout})
    end

    def renders(renders=nil)
      return @renders if defined?(@renders)
      @renders = renders
    end

    def method(key,value)
      self.class.instance_eval do
        helper_method key
        define_method key do
          value
        end
      end
    end

    def variable(key,value)
      instance_variable_set("@#{key}", value)
      self.class.instance_eval { attr_accessor key }
    end

    def to_file(path)
      @pdf.to_file(path)
    end

    def pdf_maker_assets_tag
      env = Sprockets::Environment.new

      Rails.application.assets.paths.each { |asset_path| env.append_path asset_path }

      raw "<style>#{env['application.css']}</style> <script>#{env['application.js']}</script>"
    end

  end
end
