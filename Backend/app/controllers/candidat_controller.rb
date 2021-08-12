class CandidatController < ApiController
  before_action :authorized

  def compte
    render json: {
             status: "success",
             data: {
               utilisateur_compte: {
                 id: @utilisateur.id,
                 nom: @utilisateur.nom,
                 prenom: @utilisateur.prenom,
                 email: @utilisateur.email,
                 dateDeNaissance: @utilisateur.dateDeNaissance,
                 telephone: @utilisateur.telephone,
                 niveauExperience: @utilisateur.niveauExperience,
                 passion1: @utilisateur.passion1,
                 passion2: @utilisateur.passion2,
                 passion3: @utilisateur.passion3,
               },
               parcours: @utilisateur.parcours.all.select(:id, :metier, :secteur, :experience),
             },
           }, status: :ok
  end

  def create
    @parcour = Parcour.new(parcour_params)
    if @parcour.save
      render json: {
               status: "success",
               data: {},
             }, status: :created
    else
      render json: {
               status: "fail",
               data: {
                 error: @parcour.errors,
               },
             }, status: :unprocessable_entity
    end
  end

  def update
    if @utilisateur.update(utilisateur_params)
      render json: {
               status: "success",
               data: {},
             }, status: :ok
    else
      render json: {
               status: "fail",
               data: {
                 error: @utilisateur.errors,
               },
             }, status: :unprocessable_entity
    end
  end

  def password
    if @utilisateur.authenticate(params[:password])
      head :no_content
    else
      render json: {
               status: "fail",
               data: {
                 error: "Invalid password",
               },
             }, status: :unprocessable_entity
    end
  end

  def compte_parcour
    @parcour = @utilisateur.parcours.find(params[:id])
    if @parcour.update(parcour_params)
      render json: {
               status: "success",
               data: {},
             }, status: :created
    else
      render json: {
               status: "fail",
               data: {
                 error: @parcour.errors,
               },
             }, status: :unprocessable_entity
    end
  end

  def destroy
    @parcour = @utilisateur.parcours.find(params[:id])
    @parcour.destroy
    head :no_content
  end

  def update_profil_score
    unless @utilisateur.profil_score.present?
      @utilisateur.create_profil_score
    end
    if @utilisateur.profil_score.update(profil_score_params)
      render json: {
        status: "success",
        data: {},
      }, status: :created
    else
      render json: {
        status: "fail",
        data: {
          error: @parcour.errors,
        },
      }, status: :unprocessable_entity
    end
  end
  def profil_score
    unless @utilisateur.profil_score.present?
      @utilisateur.create_profil_score
    end
    render json: {
      status: "success",
      data: {
        profil_score: {
          identity: @utilisateur.profil_score.identity,
          social: @utilisateur.profil_score.social,
          logic: @utilisateur.profil_score.logic,
          pitch: @utilisateur.profil_score.pitch
        }
      },
    }, status: :ok
  end

  private

  def utilisateur_params
    params.permit(:id, :email, :nom, :prenom, :dateDeNaissance, :telephone, :roleNo, :niveauExperience, :passion1, :passion2, :passion3, :password, :password_confirmation)
  end

  def parcour_params
    params.permit(:candidat_id, :metier, :secteur, :experience)
  end

  def profil_score_params
    params.permit(:identity, :social, :logic, :pitch)
  end
end
