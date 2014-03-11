class VisitorsController < ApplicationController

	def new
  		@visitor = Visitor.new
  	end

  	def create
  		#the create action is called upon form submission. The HTTP protocol POST is used to submit the form data to a destination URL
  		#in this case the desintation url it routed to VisitorsController#create
  		#an intance of the visitor class is created and secure attributes from the submitted form data are pass to it. 
  		@visitor = Visitor.new(secure_params)
  		#Remember, class Visitor inherts behaviour from the ActiveRecord parent class, which has a .valid method to validate requirements
  		if @visitor.valid?
  			#When the view file is rendered, the messages partial will be called. The flash hash contains :alert => message
  			#The alert variable will dictate which type of alert box is rendered, using the ternary operator
  			#Ultmately renders a div which is styled with bootstrap classes to deliever an alert box with the message from the flash hash
  			flash.now[:notice] = "Chose #{@visitor.favorite}."
  			render :new
  		else
  		#display homepage with form errors
  		render :new
  		end
  	end	

	private

	def secure_params
		#A security feature to prevent mass assignment vulenerabilites. Will only pass instances of visitor class to @visitor
		#and only permits the favorite or comment attribute to be passed. Any other attributes will be stripped.
		params.require(:visitor).permit(:favorite, :comment)
	end

end