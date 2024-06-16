class TermsOfServiceController < ApplicationController
  def show
    @term_of_service = TermOfService.find(1)
  end
end
