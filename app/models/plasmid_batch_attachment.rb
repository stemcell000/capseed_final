class PlasmidBatchAttachment < ActiveRecord::Base
 mount_uploader :attachment, AttachmentUploader
 
 belongs_to :plasmid_batch
 
 #La ligne suivante permet de supprimer l'enregistrement de plasmid_batch_attachment lorsqu'un fichier est supprimé
 #dans le formulaire. En son absence, seul le fichier est supprimé et la valeur d'":attachement" effacée.
 
 after_save { |plasmid_batch_attachment| plasmid_batch_attachment.destroy if plasmid_batch_attachment.attachment.blank? }
end
