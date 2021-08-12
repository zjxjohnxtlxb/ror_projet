ActiveAdmin.register SoftSkill do
  belongs_to :categorie_soft_skill, optional: true
  permit_params :nomSoftSkill, :categorie_soft_skill_id
  menu parent: "Param Jeu et Skills", priority: 1, if: proc{ CategorieSoftSkill.count != 0 }
  
  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to  admin_soft_skills_path
    end
  end

  sidebar "Soft Skill Management", only: [:show, :edit] do
    ul do
      li link_to "Jeu for Soft Skill", admin_soft_skill_soft_skill_jeus_path(resource)
    end
  end

  form do |f|
    f.inputs do
      f.input :categorie_soft_skill_id,  as: :select, collection: CategorieSoftSkill.all.map{|u| ["#{u.id}: #{u.nomCategorie}", u.id]}
      f.input :nomSoftSkill
      end
    f.actions
  end
  
end
