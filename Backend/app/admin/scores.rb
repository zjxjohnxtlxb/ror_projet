ActiveAdmin.register Score do
  belongs_to :utilisateur, optional: true
  permit_params :resultat, :dateScores, :utilisateur_id, :soft_skill_jeu_id
  menu parent: "Param Client et Equipe", priority: 3, if: proc { SoftSkillJeu.count > 0 }

  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to admin_scores_path
    end
  end

  form do |f|
    f.inputs do
      f.input :utilisateur_id, as: :select, collection: Utilisateur.is_candidat.map { |u| ["#{u.id}: #{u.nom} #{u.prenom}, #{u.email}", u.id] }
      f.input :soft_skill_jeu_id, as: :select, collection: SoftSkillJeu.all.map { |u| ["#{u.id}: #{u.soft_skill_id} - #{u.jeu_id}", u.id] }
      f.input :resultat
      f.input :dateScores, as: :datepicker,
                          datepicker_options: {
                            min_date: "2020-01-01",
                            max_date: "+3D",
                            changeYear: true,
                          }
    end
    f.actions
  end
end
