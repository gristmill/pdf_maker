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
    attr_accessor :view

    helper_method :pdf_assets

    def pdf_assets
      env = Sprockets::Environment.new

      Rails.application.assets.paths.each { |asset_path| env.append_path asset_path }

      x = "<style>#{env['application.css']}</style> <script>#{env['application.js']}</script>"
      puts x
      raw(x)
    end

    # PdfMaker.new do
    #
    #   view 'users/profile'
    #   layout 'pdf_layout.html.erb'
    #
    #   context do
    #     @message = "Hello World"
    #   end
    #
    #   methods do
    #     current_user = nil
    #   end
    #
    # end
    # def view
    #   @view
    # end
    #
    # def view=(view)
    #   @view = view
    # end
    def initialize(&block)
      instance_eval(&block)

      @options ||= {}

      if @layout
        @options.merge({layout: @layout})
      end

      @pdf = PDFKit.new(render(@view, @options))
    end

    def layout(layout=nil)
      if @layout && layout.nil?
        @layout
      else
        @layout = layout
      end
    end

    def view(view=nil)
      if @view && view.nil?
        @view
      else
        @view = view
      end
    end

    def to_file(path)
      @pdf.to_file(path)
    end
  end
end
