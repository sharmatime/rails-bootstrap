class Visitor < ActiveRecord::Base
	has_no_table #use the activerecord_tabeless gem to turn off SQLite3 database features
	column :favorite, :string #create string attribues for :favorite and :comment
	column :comment, :string
	validates_presence_of :favorite #only validate presence of favorite, don't care if comment is filled out

	#Create a constant, which returns an array containing a name for each image the visitor will see
	#we'll use this contstant in multiple places, so by creating it in the model, it means its hardcoded only once
	IMAGE_LABELS = ['Salty', 'Simba King', 'Thomas Jefferson', 'Ranger'] 

end