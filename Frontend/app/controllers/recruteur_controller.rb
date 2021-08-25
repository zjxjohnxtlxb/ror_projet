class RecruteurController < ApplicationController
  def equipe_manager
    unless session[:recruteur].present?
      flash[:info]= 'please login'
      redirect_to action: :login and return
    end
    @candidats = get_candidats
    @recruteur = session[:recruteur].transform_keys(&:to_sym)
    @equipes, @equipes_index = get_equipes(@recruteur, @candidats)
    if request.post?
      if params["equipe"]["id"] == "new"
        if params["equipe"]["candidats"].present?
          equipe_temp = Hash.new
          equipe_temp[:id] = @equipes_index + 1
          equipe_temp[:candidats] = Array.new
          params["equipe"]["candidats"].each do |id|
            @candidats.each do |candidat|
              if candidat[:id] == id.to_i
                equipe_temp[:candidats].push(candidat)
              end
            end
          end
          equipe_temp[:recruteur] = @recruteur
          equipe_temp[:nomEquipe] = params["equipe"]["nomEquipe"]
          equipe_temp[:niveauImportance] = params["equipe"]["niveauImportance"]
          @equipes.push(equipe_temp)
          ### save dans le back
          res = post "/equipe", equipe_info_params, head_options(token: session[:token])
          case res["status"] ||= res[:status]
          when "error"
            flash.now[:danger] = "Erreur de connexion au serveur"
          when "success"
            params["equipe"]["candidats"].each do |candidat|
              equipe_params = { recruteur_id: @recruteur[:id],
                                equipe_soft_skill_id: equipe_temp[:id],
                                candidat_id: candidat }
              res = post "/equipes", equipe_params, head_options(token: session[:token])
            end
          end
        else
          flash.now[:light] = "Candidat cannot be empty"
        end
      else
        update_temp = Hash.new
        @equipes.each do |equipe|
          if equipe[:id] == params["equipe"]["id"].to_i
            if params["equipe"]["candidats"].present?
              params["equipe"].each do |key, value|
                unless key == "candidats"
                  if equipe[key.to_sym] != value
                    equipe[key.to_sym] = value
                    update_temp[key.to_sym] = value
                  end
                else
                  candidats_temp = Array.new
                  equipe[:candidats].each do |candidat|
                    candidats_temp.push(candidat[:id].to_s)
                  end
                  unless candidats_temp.sort == (params["equipe"]["candidats"].sort)
                    equipe[:candidats] = Array.new
                    params["equipe"]["candidats"].each do |id|
                      @candidats.each do |candidat|
                        if candidat[:id] == id.to_i
                          equipe[:candidats].push(candidat)
                        end
                      end
                    end
                    #### update dans le back
                    ### add
                    add_temp = params["equipe"]["candidats"] - candidats_temp
                    add_temp.each do |add_t|
                      equipe_params = { recruteur_id: @recruteur[:id],
                                        equipe_soft_skill_id: params["equipe"]["id"],
                                        candidat_id: add_t.to_i }
                      res = post "/equipes", equipe_params, head_options(token: session[:token])
                    end
                    ### delete
                    delete_temp = candidats_temp - params["equipe"]["candidats"]
                    delete_temp.each do |d_t|
                      res = delete "equipes/#{@recruteur[:id]}/#{params["equipe"]["id"]}/#{d_t}", session[:token]
                    end
                  end
                end
              end
              unless update_temp.empty?
                res = patch "/equipe/#{params["equipe"]["id"]}", update_temp, session[:token]
              end
            else
              flash.now[:light] = "Candidat cannot be empty"
            end
          end
        end
      end
    end
    render Equipe::EquipeWorkshopComponent.new(equipes: @equipes, candidats: @candidats, recruteur: @recruteur)
  end

  def delete_equipe
    res = delete "equipe/#{params["id"]}", session[:token]
    head :no_content
  end

  def login
    if request.post?
      res = post "connexion_recruteur", params["utilisateur"]
      case res["status"] ||= res[:status]
      when "error"
        flash.now[:danger] = "Erreur de connexion au serveur"
      when "fail"
        flash.now[:warning] = res["data"]["error"]
      when "forbidden"
        flash.now[:info] = res["data"]["message"]
      when "success"
        session[:recruteur] = res["data"]["utilisateur"]
        redirect_to action: :equipe_manager
      end
    end
  end

  private

  def get_candidats
    res = get "candidats", head_options(token: session[:token], keys: [1])
    candidates = Array.new
    res["data"]["candidats"].each do |candidat|
      candidates.push(candidat.transform_keys(&:to_sym))
    end
    candidates
  end

  def get_equipes(recruteur, candidats)
    res = get "equipes/#{recruteur[:id]}", head_options(token: session[:token], keys: [1])
    equipes_temp = Array.new
    res["data"]["equipes_info"].each do |equipe_info|
      equipe_temp = { recruteur: recruteur }
      equipe_temp[:id] = equipe_info[0]["id"]
      equipe_temp[:nomEquipe] = equipe_info[0]["nomEquipe"]
      equipe_temp[:niveauImportance] = equipe_info[0]["niveauImportance"]
      equipe_temp[:soft_skill_id] = equipe_info[0]["soft_skill_id"]
      equipe_temp[:candidats] = Array.new
      res["data"]["equipes"].each do |equipe|
        if equipe[0]["equipe_soft_skill_id"] == equipe_temp[:id]
          equipe.each do |e|
            candidats.each do |c|
              if c[:id] == e["candidat_id"]
                equipe_temp[:candidats].push(c)
              end
            end
          end
        end
      end
      equipes_temp.push(equipe_temp)
    end
    [equipes_temp, res["data"]["equipes_index"]]
  end

  def equipe_info_params
    params["equipe"].permit(:id, :nomEquipe, :niveauImportance, :soft_skill_id, :candidats)
  end
end
