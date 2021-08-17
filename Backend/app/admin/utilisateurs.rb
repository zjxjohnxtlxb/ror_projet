ActiveAdmin.register Utilisateur do
  permit_params :nom, :prenom, :email, :dateDeNaissance, :telephone, :roleNo, :password, :password_confirmation
  menu parent: "Param Client et Equipe", priority: 0

  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to admin_utilisateurs_path
    end
  end

  sidebar "Utilisateur Details", only: [:show, :edit] do
    ul do
      li link_to "Parcour", admin_utilisateur_parcours_path(resource)
      if Utilisateur.is_candidat.find_by(id: utilisateur.id)
        unless utilisateur.profil_score.present?
          utilisateur.create_profil_score
        end
        li link_to "Profil Score", admin_utilisateur_profil_score_path(utilisateur, utilisateur.profil_score.id)
      end
    end
  end

  index do
    selectable_column
    id_column
    column :nom
    column :prenom
    column :email
    column :dateDeNaissance
    column :telephone
    column :roleNo
    actions
  end

  filter :nom
  filter :prenom
  filter :email
  filter :dateDeNaissance
  filter :telephone
  filter :roleNo_equals

  form do |f|
    f.inputs do
      f.input :nom
      f.input :prenom
      f.input :email
      f.input :dateDeNaissance, as: :datepicker,
                                datepicker_options: {
                                  min_date: "1950-01-01",
                                  max_date: "+3D",
                                  changeYear: true,
                                }
      f.input :telephone
      f.input :roleNo, as: :select, collection: { "0 - recruteur" => 0, "1 - candidat" => 1 }
      f.input :password
      f.input :password_confirmation
      f.input :niveauExperience
      f.input :passion1
      f.input :passion2
      f.input :passion3
      f.input :linkFacebook
      f.input :linkTwitter
      f.input :linkLinkedin
      f.input :linkViadeo
    end
    f.actions
  end
end
