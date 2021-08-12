class ApiController < ActionController::API
  def encode_token(payload)
    JWT.encode payload, "abilitizSecu", "HS256"
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers["Authorization"]
  end

  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode token, "abilitizSecu", true, { algorithm: "HS256" }
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def load_payload
    if decoded_token
      decoded_token[0]
    else
      nil
    end
  end

  def logged_in_utilisateur
    unless validat_payload?
      render json: {
               status: "fail",
               data: {
                 message: "Please log in",
               },
             }, status: :unauthorized
    else
      utilisateur_id = load_payload["utilisateur_id"]
      @utilisateur = Utilisateur.find_by(id: utilisateur_id)
    end
  end

  def validat_payload?
    load_payload["iss"] == "Abilitiz" && load_payload["exp"].to_i > Time.now.to_i
  end

  def logged_in?
    !!load_payload && !!logged_in_utilisateur
  end

  def authorized
    render json: {
             status: "unauthorized",
             data: {
               message: "Please log in",
             },
           }, status: :unauthorized unless logged_in?
  end

  def age(birthday)
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end
end
