ActiveAdmin.register CategorieSoftSkill do
  permit_params :nomCategorie
  menu parent: "Param Jeu et Skills", priority: 0
  
  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to admin_categorie_soft_skills_path
    end
  end

  sidebar "Categorie Soft Skill Management", only: [:show, :edit] do
    ul do
      li link_to "Soft Skill", admin_categorie_soft_skill_soft_skills_path(resource)
    end
  end
  
end
