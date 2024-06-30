require 'rails_helper'

RSpec.describe StaticController, type: :controller do

  describe "GET #privacy_policy" do
    it "returns http success" do
      get :privacy_policy
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #term_of_service" do
    it "returns http success" do
      get :term_of_service
      expect(response).to have_http_status(:success)
    end
  end

end
