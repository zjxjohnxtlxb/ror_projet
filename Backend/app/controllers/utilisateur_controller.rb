class UtilisateurController < ApiController
  before_action :authorized, only: [:auto_login]

  VALID_TIME = 5 * 60

  # REGISTER
  def create
    @utilisateur = Utilisateur.create(utilisateur_params)
    if @utilisateur.valid?
      token = encode_token(
        { iss: "Abilitiz",
          utilisateur_id: @utilisateur.id,
          roleNo: @utilisateur.roleNo,
          exp: Time.now.to_i + VALID_TIME }
      )
      render json: {
        status: "success",
        data: {},
      }, status: :created
    else
      render json: {
        status: "fail",
        data: {
          error: "Invalid username or password",
        },
      }, status: :unprocessable_entity
    end
  end

  # LOGGING IN
  def login
    @utilisateur = Utilisateur.find_by(email: params[:email])

    if @utilisateur && @utilisateur.authenticate(params[:password])
      case @utilisateur.roleNo
      when 0
        render json: {
                 status: "forbidden",
                 data: {
                   message: "Error Type Client",
                 },
               }, status: :forbidden
      when 1
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
              dateDeNaissance: @utilisateur.dateDeNaissance ||= "1999/08/15",
              age: age((@utilisateur.dateDeNaissance ||= "1999/08/15").to_date),
              telephone: @utilisateur.telephone ||= "07 89 01 23 45",
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
    render json: {
             status: "success",
             data: {
               utilisateur: {
                 id: @utilisateur.id,
                 nom: @utilisateur.nom,
                 prenom: @utilisateur.prenom,
                 email: @utilisateur.email,
                 dateDeNaissance: @utilisateur.dateDeNaissance ||= "1999/08/15",
                 age: age((@utilisateur.dateDeNaissance ||= "1999/08/15").to_date),
                 telephone: @utilisateur.telephone ||= "07 89 01 23 45",
               },
             },
           }, status: :ok
  end

  def headers
    headers = {}
    headers["Content-Type"] = request.headers["Content-Type"] unless request.headers["Content-Type"].nil?
    headers["Authorization"] = request.headers["Authorization"] unless request.headers["Authorization"].nil?
    headers
  end

  def connectable
    render json: {
             status: "connectable",
             data: {
               type: request.method,
               headers: headers,
               params: params,
             },
           }, status: :ok
  end

  private

  def utilisateur_params
    params.permit(:id, :email, :nom, :prenom, :roleNo, :password, :password_confirmation)
  end
end
