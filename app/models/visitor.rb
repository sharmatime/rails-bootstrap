class Visitor < ActiveRecord::Base
	has_no_table #use the activerecord_tabeless gem to turn off SQLite3 database features
	column :favorite, :string #create string attribues for :favorite and :comment
	column :comment, :string
	validates_presence_of :favorite #only validate presence of favorite, don't care if comment is filled out

	#Create a constant, which returns an array containing a name for each image the visitor will see
	#we'll use this contstant in multiple places, so by creating it in the model, it means its hardcoded only once
	IMAGE_LABELS = ['Salty', 'King', 'Thomas Jefferson', 'Ranger', 'Coco'] 

	def update_spreadsheet
		connection = GoogleDrive.login(Rails.application.secrets.gmail_username, Rails.application.secrets.gmail_password)
		ss = connection.spreadsheet_by_title('Rails-Bootstrap-Example')
		if ss.nil?
			ss = connection.create_spreadsheet('Rails-Bootstrap-Example')
		end
		ws = ss.worksheets[0]
		last_row = 1 + ws.num_rows
		ws[last_row, 1] = Time.now
		ws[last_row, 2] = self.favorite
		ws[last_row, 3] = self.comment
		ws.save
	end

end

#the update_spreadsheet method will be called from the controller once the form data is secure and validated 
#Create a connection to GoogleDrive by passing your credentials to the login method. 
#We look for a spreadsheet_by_title. If it doesn't exist, we create one. 
#A single spredsheet can contain multiple worksheets. We'll use only one worksheet to store our data designated as worksheet 0.
#To add a row to the spreadsheet we need to add 1 + ws.num_rows (because currently no rows exist)
#Add data on a cell by cell basis. We refer to the current instance of the class by using the keyword self
#setting up the spreadsheet doesn't save the data. We explicitlty call the worksheet save method. 