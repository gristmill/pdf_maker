require 'test_helper'
require 'fileutils'

class PdfMakerTest < ActiveSupport::TestCase
  setup do
    @pdf_maker = PdfMaker::Base.new(view: "test/dummy/app/views/users/profile",
      locals: { name: "Sean"},
      ivars:  { message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit...", credits: "Sean Behan"}
      # ,
      # layout: "test/dummy/app/views/layouts/pdf"
    )
    FileUtils.mkdir_p("test/test_pdfs")
  end

  teardown do
    FileUtils.rm_rf(Dir["test/test_pdfs"])
  end

  test "writes the file" do
    assert @pdf_maker.to_file("test/test_pdfs/application.html.pdf")
    assert File.exists?("test/test_pdfs/application.html.pdf")
    assert_equal("%PDF", File.read("test/test_pdfs/application.html.pdf").to_s[0...4])
  end
end
