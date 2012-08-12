require 'test_helper'
require 'fileutils'

class PdfMakerTest < ActiveSupport::TestCase
  # setup do
  #   @pdf_maker = PdfMaker::Base.new(view: "test/dummy/app/views/users/profile",
  #     locals: { name: "Sean"},
  #     ivars:  { message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit...", credits: "Sean Behan"}
  #     # ,
  #     # layout: "test/dummy/app/views/layouts/pdf"
  #   )
  #   FileUtils.mkdir_p("test/test_pdfs")
  # end
  #
  # teardown do
  #   FileUtils.rm_rf(Dir["test/test_pdfs"])
  # end

  test "dsl" do
    pdf = PdfMaker::Base.new do
      view 'test/dummy/app/views/users/profile'
      layout 'pdf'

      # Instance variables used
      @message = "Hello World"

      # Define methods (add to helper)
      def current_user
        "Sean"
      end
    end

    assert_equal 'test/dummy/app/views/users/profile', pdf.view
    assert_equal 'pdf', pdf.layout
    assert_equal "Hello World", pdf.instance_variable_get("@message")
    assert_equal "Sean", pdf.current_user
  end

  # test "writes the file" do
  #   assert @pdf_maker.to_file("test/test_pdfs/application.html.pdf")
  #   assert File.exists?("test/test_pdfs/application.html.pdf")
  #   assert_equal("%PDF", File.read("test/test_pdfs/application.html.pdf").to_s[0...4])
  # end
end
