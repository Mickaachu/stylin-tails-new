require "test_helper"
require "devise/test/integration_helpers"

class PetsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @pet = pets(:one)
    @user = User.create!(email: "pet-owner@example.com", password: "password123")
    sign_in @user
  end

  test "should get index" do
    get pets_url
    assert_response :success
  end

  test "should get new" do
    get new_pet_url
    assert_response :success
  end

  test "should create pet for the current owner" do
    assert_difference("Pet.count") do
      post pets_url, params: { pet: { breed: "Golden Retriever", name: "Milo", notes: "Very friendly", size: "Medium" } }
    end

    assert_equal @user.owner, Pet.last.owner
    assert_redirected_to pet_url(Pet.last)
  end

  test "should show pet" do
    get pet_url(@pet)
    assert_response :success
  end

  test "should get edit" do
    get edit_pet_url(@pet)
    assert_response :success
  end

  test "should update pet" do
    patch pet_url(@pet), params: { pet: { breed: @pet.breed, name: @pet.name, notes: @pet.notes, size: @pet.size } }
    assert_redirected_to pet_url(@pet)
  end

  test "should destroy pet" do
    assert_difference("Pet.count", -1) do
      delete pet_url(@pet)
    end

    assert_redirected_to pets_url
  end
end
