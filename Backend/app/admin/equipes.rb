ActiveAdmin.register Equipe do
  belongs_to :utilisateur, optional: true
  permit_params :recruteur_id, :candidat_id, :equipe_soft_skill_id
  menu parent: "Param Client et Equipe", priority: 2, if: proc{ Utilisateur.is_recruteur.count > 0 && Utilisateur.is_candidat.count > 0 && EquipeSoftSkill.count > 0}

  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to admin_equipes_path
    end
  end

  form do |f|
    f.inputs do
      f.input :equipe_soft_skill_id,  as: :select, collection: EquipeSoftSkill.all.map{|u| ["#{u.id}: #{u.nomEquipe}", u.id]}
      f.input :recruteur_id, as: :select, collection: Utilisateur.is_recruteur.map{|u| ["#{u.id}: #{u.nom} #{u.prenom}, #{u.email}", u.id]}
      f.input :candidat_id, as: :select, collection: Utilisateur.is_candidat.map{|u| ["#{u.id}: #{u.nom} #{u.prenom}, #{u.email}", u.id]}
    end
    f.actions
  end
  
end
