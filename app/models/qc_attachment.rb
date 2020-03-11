class QcAttachment < ActiveRecord::Base
 mount_uploader :attachment, AttachmentUploader
 
 has_and_belongs_to_many :clone_batch_qcs
 has_and_belongs_to_many :plasmid_batch_qcs
 has_and_belongs_to_many :sequencings
 has_and_belongs_to_many :pcr_colonies
 
 #La ligne suivante permet de supprimer l'enregistrement de qc_attachment lorsqu'un fichier est supprimé
 #dans le formulaire. En son absence, seul le fichier est supprimé et la valeur d'":attachement" effacée.
 
 after_save { |qc_attachment| qc_attachment.destroy if qc_attachment.attachment.blank? }

end
