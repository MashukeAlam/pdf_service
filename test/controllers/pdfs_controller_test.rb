require "test_helper"

class PdfsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pdfs_url
    assert_response :success
  end

  test "should get new" do
    get new_pdf_url
    assert_response :success
  end


  test "should create PDF via API and redirect to status" do
    template = Template.create!(name: 'API Test', signature: {foo: 'bar'}, content: '<h1><%= foo %></h1>')
    post pdfs_url, params: { pdf: { template_id: template.id, data: '{"foo":"bar"}' } }, headers: { 'Accept' => 'text/html' }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match /PDF Generation Status/, @response.body
  end

  test "should show PDF status page" do
    get pdf_url('nonexistent.pdf'), headers: { 'Accept' => 'text/html' }
    assert_response :success
    assert_match /PDF Generation Status/, @response.body
  end
end
