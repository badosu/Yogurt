require './test/test_helper'

class CommunitiesTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    Yogurt.app
  end

  def test_index_shows_created_community
    community_name = "A nice community"
    community = Community.create name: community_name

    get "/communities"

    assert last_response.ok?
    assert last_response.body.include? community_name
  end

  def test_edit_existing_community
    community_name = "A nice community"
    community = Community.create name: community_name

    get "/communities/#{community.id}/edit"

    assert last_response.ok?
    assert last_response.body.include? community_name
  end

  def test_edit_absent_community
    get "/communities/999/edit"

    refute last_response.ok?
    assert last_response.status == 404
  end

  def test_delete_existing_community
    community_name = "A nice community"
    community = Community.create name: community_name

    id = community.id

    delete "/communities/#{id}"

    follow_redirect!

    assert Community[id].nil?
    assert_equal last_request.path, "/communities"
  end

  def test_delete_absent_community
    delete "/communities/999"

    refute last_response.ok?
    assert last_response.status == 404
  end
end
