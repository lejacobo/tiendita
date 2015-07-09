class PaymentController < ApplicationController

	def confirmation
		logger.info ' ola ti '
		render text: '1'
	end

end
