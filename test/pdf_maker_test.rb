require 'test_helper'
require 'fileutils'

class PdfMakerTest < ActiveSupport::TestCase
  setup do
    FileUtils.mkdir_p("test/test_pdfs")
  end

  teardown do
    FileUtils.rm_rf(Dir["test/test_pdfs"])
  end

  def test_context
    pdf = PdfMaker::Base.new do
      layout 'test/dummy/app/views/layouts/pdf'
      renders 'test/dummy/app/views/users/profile'

      variable  :message, "Hello"
      method    :current_user, "Sean"
    end

    assert pdf
    assert_equal "Hello", pdf.message
    assert_equal "Sean",  pdf.current_user
    assert pdf.to_file("test/test_pdfs/test_pdf.pdf")
    assert_equal "%PDF", File.read("test/test_pdfs/test_pdf.pdf")[0...4]
  end

end
