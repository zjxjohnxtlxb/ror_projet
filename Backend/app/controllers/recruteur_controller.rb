class RecruteurController < ApiController
  #before_action :authorized, except: [:login]

  VALID_TIME = 5 * 60

  # LOGGING IN
  def login
    @utilisateur = Utilisateur.find_by(email: params[:email])

    if @utilisateur && @utilisateur.authenticate(params[:password])
      case @utilisateur.roleNo
      when 1
        render json: {
                 status: "forbidden",
                 data: {
                   message: "Error Type Client",
                 },
               }, status: :forbidden
      when 0
        token = encode_token(
          { iss: "Abilitiz",
            utilisateur_id: @utilisateur.id,
            roleNo: @utilisateur.roleNo,
            exp: Time.now.to_i + VALID_TIME }
        )
        render json: {
          status: "success",
          data: {
            token: token,
            utilisateur: {
              id: @utilisateur.id,
              nom: @utilisateur.nom,
              prenom: @utilisateur.prenom,
              email: @utilisateur.email,
            },
          },
        }, status: :ok
      end
    else
      render json: {
               status: "fail",
               data: {
                 error: "Invalid username or password",
               },
             }, status: :unauthorized
    end
  end

  def auto_login
    if load_payload["roleNo"] == 0
      render json: {
               status: "success",
               data: {
                 utilisateur: {
                   id: @utilisateur.id,
                   nom: @utilisateur.nom,
                   prenom: @utilisateur.prenom,
                   email: @utilisateur.email,
                 },
               },
             }, status: :ok
    else
      render json: {
               status: "fail",
               data: {
                 message: "Error Type Client",
               },
             }, status: :unauthorized
    end
  end

  def candidats
    @candidats = Utilisateur.is_candidat
    render json: {
             status: "success",
             data: {
               candidats: @candidats.select(:id, :nom, :prenom, :email),
             },
           }, status: :ok
  end

  def equipes
    @equipes = Array.new
    @equipes_info = Array.new
    equipes_temp = Equipe.get_equipes(params[:id])
    equipes_temp.each do |equipe_temp|
      candidats_temp = Equipe.get_candidats(equipe_temp.equipe_soft_skill_id).select(:id, :recruteur_id, :candidat_id, :equipe_soft_skill_id)
      @equipes.push(candidats_temp)
      equipe_info = EquipeSoftSkill.where(["id = ?", equipe_temp.equipe_soft_skill_id]).select(:id, :nomEquipe, :niveauImportance, :soft_skill_id)
      @equipes_info.push(equipe_info)
    end


    render json: {
             status: "success",
             data: {
               equipes_index: Equipe.ids.last,
               equipes_info: @equipes_info,
               equipes: @equipes,
             },
           }, status: :ok
  end

  def destroy
    @equipe = Equipe.get_equipes(params[:id]).find_by(equipe_soft_skill_id: params[:equipe_id], candidat_id: params[:candidat_id])
    @equipe.destroy
    head :no_content
  end

  def create
    @equipe = Equipe.new(equipe_params)
    if @equipe.save
      render json: {
               status: "success",
               data: {},
             }, status: :created
    else
      render json: {
               status: "fail",
               data: {
                 error: @equipe.errors,
               },
             }, status: :unprocessable_entity
    end
  end

  def create_equipe
    @equipe_soft_skill = EquipeSoftSkill.new(equipe_soft_skill_params)
    if @equipe_soft_skill.save
      render json: {
               status: "success",
               data: {},
             }, status: :created
    else
      render json: {
               status: "fail",
               data: {
                 error: @equipe_soft_skill.errors,
               },
             }, status: :unprocessable_entity
    end
  end

  def update_equipe
    @equipe_soft_skill = EquipeSoftSkill.find_by(id: params[:id])
    if @equipe_soft_skill.update(equipe_soft_skill_params)
      render json: {
               status: "success",
               data: {},
             }, status: :ok
    else
      render json: {
               status: "fail",
               data: {
                 error: @equipe_soft_skill.errors,
               },
             }, status: :unprocessable_entity
    end
  end

  def destroy_equipe
    @equipe = EquipeSoftSkill.find_by(id: params[:id])
    @equipe.destroy
    head :no_content
  end

  private

  def equipe_params
    params.permit(:recruteur_id, :candidat_id, :equipe_soft_skill_id)
  end

  def equipe_soft_skill_params
    params.permit(:nomEquipe, :niveauImportance, :soft_skill_id)
  end
end
