ActiveAdmin.register SoftSkillJeu do
  permit_params :soft_skill_id, :jeu_id
  belongs_to :soft_skill, optional: true
  menu label: "Soft skill jeux", parent: "Param Jeu et Skills", priority: 3, if: proc { SoftSkill.count != 0 && Jeu.count != 0 }

  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to admin_soft_skill_jeus_path
    end
  end

  form do |f|
    f.inputs do
      f.input :soft_skill_id, as: :select, collection: SoftSkill.all.map { |u| ["#{u.id}: #{u.nomSoftSkill} - #{u.categorie_soft_skill_id}", u.id] }
      f.input :jeu_id, as: :select, collection: Jeu.all.map { |u| ["#{u.id}: #{u.nomJeu}", u.id] }
    end
    f.actions
  end
end
