class ApplicationController < Jets::Controller::Base
	skip_before_action :verify_authenticity_token, raise: false
	protect_from_forgery unless: -> { request.format.json? }

end
