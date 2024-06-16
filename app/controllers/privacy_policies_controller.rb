class PrivacyPoliciesController < ApplicationController
  def show
    @privacy_policy = PrivacyPolicy.find(1)
  end
end
