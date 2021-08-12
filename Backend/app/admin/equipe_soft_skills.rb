ActiveAdmin.register EquipeSoftSkill do
  belongs_to :equipe, optional: true
  permit_params :niveauImportance, :soft_skill_id, :nomEquipe
  menu parent: "Param Client et Equipe", priority: 1, if: proc{ SoftSkill.count > 0 }
  
  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to admin_equipe_soft_skills_path
    end
  end

  form do |f|
    f.inputs do
      f.input :soft_skill_id,  as: :select, collection: SoftSkill.all.map{|u| ["#{u.id}: #{u.nomSoftSkill} - #{u.categorie_soft_skill_id}", u.id]}
      f.input :nomEquipe
      f.input :niveauImportance
      end
    f.actions
  end

end
