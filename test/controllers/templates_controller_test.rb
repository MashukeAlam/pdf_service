require "test_helper"

class TemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get templates_url
    assert_response :success
  end

  test "should get new" do
    get new_template_url
    assert_response :success
  end

  test "should create template" do
    assert_difference('Template.count') do
      post templates_url, params: { template: { name: 'Test', signature: '{}', content: '<h1>Test</h1>' } }
    end
    assert_redirected_to template_url(Template.last)
  end

  test "should show template" do
    template = Template.create!(name: 'Show', signature: '{}', content: '<h1>Show</h1>')
    get template_url(template)
    assert_response :success
  end
end
