class CloneBatchAsPlasmidAttachment < ActiveRecord::Base
 mount_uploader :attachment, AttachmentUploader
 
 belongs_to :clone_batch
 
 #La ligne suivante permet de supprimer l'enregistrement de Clone_batch_attachment lorsqu'un fichier est supprimé
 #dans le formulaire. En son absence, seul le fichier est supprimé et la valeur d'":attachement" effacée.
 
 after_save { |clone_batch_as_plasmid_attachment| clone_batch_as_plasmid_attachment.destroy if clone_batch_as_plasmid_attachment.attachment.blank? }
end
