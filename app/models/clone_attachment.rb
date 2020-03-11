class CloneAttachment < ActiveRecord::Base
 mount_uploader :attachment, AttachmentUploader
 belongs_to :clone
 #La ligne suivante permet de supprimer l'enregistrement ce Clone_attachment lorsqu'un fichier est supprimé
 #dans le formulaire. En son absence, seul le fichier est supprimé et la valeur d'":attachement" effacée.
 after_save { |clone_attachment| clone_attachment.destroy if clone_attachment.attachment.blank? }
end
