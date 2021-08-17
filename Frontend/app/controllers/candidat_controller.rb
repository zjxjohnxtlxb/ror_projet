class CandidatController < ApplicationController
  add_flash_types :success, :danger, :warning, :info
  before_action :auto_login, except: [:connexion, :deconnexion]
  before_action :check_redirect_to_index, only: :index
  before_action :check_redirect_to, except: [:index, :connexion]
  after_action :check_referrer, only: :compte_post

  #rescue_from NoMethodError, with: :please_login

  def auto_login
    if session[:token].present?
      res = get "auto_connexion", head_options(token: session[:token], keys: [1])
      case res["status"] ||= res[:status]
      when "error"
        flash[:danger] = "Erreur de connexion au serveur"
        session[:redirect_to] = true
      when "fail"
        flash[:warning] = res["data"]["message"]
        session[:redirect_to] = true
      when "unauthorized"
        flash[:info] = res["data"]["message"]
        session[:redirect_to] = true
      when "success"
        session[:utilisateur] = res["data"]["utilisateur"]
        session[:utilisateur_id] = session[:utilisateur]["id"]
        session[:redirect_to] = false
      end
    else
      session[:redirect_to] = true
    end
  end

  def check_redirect_to
    if session[:redirect_to] == true
      session[:redirect_to] = false
      $check_redirect_to = true
    end
  end

  def check_redirect_to_index
    if $check_redirect_to
      $check_redirect_to = false
      session[:token] = nil
      session[:utilisateur_id] = nil
      redirect_to action: :connexion
    end
  end

  def check_referrer
    unless session[:no_need_referrer]
      session[:no_need_referrer] = false
      $referrer = true
    end
  end

  def please_login
    render inline: '<% content_for :css do -%><% stylesheet_link_tag "bootstrap", media: "all", "data-turbolinks-track": "reload" %><% end -%><%= tag.div id: "container", class: "alert alert-info", data: { source: $check_redirect_to.to_json } do %>please login in<% end %><%= javascript_pack_tag "redirect"%>', layout: "application"
  end

  def connexion
    if session[:token] && session[:utilisateur_id]
      redirect_to action: :index
    end
    if request.post?
      res = post "connexion", params["utilisateur"]
      case res["status"] ||= res[:status]
      when "error"
        flash.now[:danger] = "Erreur de connexion au serveur"
      when "fail"
        flash.now[:warning] = res["data"]["error"]
      when "forbidden"
        flash.now[:info] = res["data"]["message"]
      when "success"
        session[:token] = res["data"]["token"]
        redirect_to action: :index
      end
    end
  end

  def deconnextion
    session[:token] = nil
    session[:utilisateur_id] = nil
    flash[:info] = "Success deconnextion"
    redirect_to action: :connexion
  end

  def index
    @utilisateur = session[:utilisateur]
    if $referrer == true
      $referrer = false
    end
  end

  def partiel_home
    @utilisateur = session[:utilisateur]
  end

  def partiel_compte
    res = get "compte", head_options(token: session[:token], keys: [1])
    case res["status"] ||= res[:status]
    when "error"
      flash.now[:danger] = "Erreur de connexion au serveur"
    when "success"
      @utilisateur_compte = res["data"]["utilisateur_compte"]
      @parcours = res["data"]["parcours"]
    end
  end

  def compte_post
    if params["utilisateur"].present?
      if params["utilisateur"]["password"].present?
        password = {
          password: params["utilisateur"]["password"],
        }
        res = post "/candidats/#{session[:utilisateur_id]}/password", password, head_options(token: session[:token])
        if res["status"] == "fail"
          flash.now[:info] = res["data"]["error"]
          session[:no_need_referrer] = true
        else
          params["utilisateur"]["password"] = params["newPassword"]
        end
      end
      res = patch "/candidats/#{session[:utilisateur_id]}", params["utilisateur"], session[:token]
      case res["status"] ||= res[:status]
      when "error"
        flash[:danger] = "Erreur de connexion au serveur"
        session[:no_need_referrer] = true
      when "fail"
        flash[:warning] = res["data"]["error"]
        session[:no_need_referrer] = true
      when "success"
        flash[:info] = "Success update utilisateur"
      end
    end
    if params["parcour"].present?
      deleteParcour = params["parcour"].select { |key, value|
        value.has_key?("delete")
      }
      newParcour = params["parcour"].select { |key, value| key.start_with?("new") }
      updateParcour = params["parcour"].reject { |key, value|
        keys = deleteParcour.keys.to_a + newParcour.keys.to_a
        keys.include?(key)
      }
      if deleteParcour.present?
        deleteParcour.each { |key, value|
          res = delete "/candidats/#{session[:utilisateur_id]}/parours/#{key}", session[:token]
          case res["status"] ||= res[:status]
          when "error"
            flash[:danger] = "Erreur de connexion au serveur"
            session[:no_need_referrer] = true
          when "success"
            flash[:info] << "<br>" unless flash[:info].blank?
            flash[:info].blank? ? flash[:info] = "Success delete parcour #{key}" : flash[:info] << "Success delete parcour #{key}"
          end
        }
      end
      if newParcour.present?
        newParcour.each { |key, value|
          parcour = newParcour.dig(key)
          res = post "/candidats/#{session[:utilisateur_id]}/parours", parcour, head_options(token: session[:token])
          case res["status"] ||= res[:status]
          when "error"
            flash[:danger] = "Erreur de connexion au serveur"
            session[:no_need_referrer] = true
          when "fail"
            flash[:warning] << "<br>" unless flash[:warning].blank?
            flash[:warning].blank? ? flash[:warning] = res["data"]["error"] : flash[:warning] << res["data"]["error"]
            session[:no_need_referrer] = true
          when "success"
            flash[:info] << "<br>" unless flash[:info].blank?
            flash[:info].blank? ? flash[:info] = "Success add parcour #{key}" : flash[:info] << "Success add parcour #{key}"
          end
        }
      end
      if updateParcour.present?
        updateParcour.each { |key, value|
          parcour = updateParcour.dig(key)
          res = patch "/candidats/#{session[:utilisateur_id]}/parcours/#{key}", parcour, session[:token]
          case res["status"] ||= res[:status]
          when "error"
            flash[:danger] = "Erreur de connexion au serveur"
            session[:no_need_referrer] = true
          when "fail"
            flash[:warning] << "<br>" unless flash[:warning].blank?
            flash[:warning].blank? ? flash[:warning] = res["data"]["error"] : flash[:warning] << res["data"]["error"]
            session[:no_need_referrer] = true
          when "success"
            flash[:info] << "<br>" unless flash[:info].blank?
            flash[:info].blank? ? flash[:info] = "Success update parcour #{key}" : flash[:info] << "Success update parcour #{key}"
          end
        }
      end
    end
    redirect_to action: :partiel_compte
  end

  def partiel_profil
    res = get "/candidats/#{session[:utilisateur_id]}/profil_score", head_options(token: session[:token], keys: [1])
    case res["status"] ||= res[:status]
    when "error"
      flash.now[:danger] = "Erreur de connexion au serveur"
    when "success"
      @profil_score = res["data"]["profil_score"]
    end
    if profil_score_params.present?
      res = patch "/candidats/#{session[:utilisateur_id]}/profil_score", profil_score_params, session[:token]
      case res["status"] ||= res[:status]
      when "error"
        flash.now[:danger] = "Erreur de connexion au serveur"
      when "fail"
        flash.now[:warning] = res["data"]["error"]
      when "success"
        flash[:info] = "Your score updated"
        redirect_to action: 'partiel_profil'
      end
    end
  end

  def partiel_cv
  end

  def cv_partager
    send_file 'app/assets/pdfs/cv.pdf', type: 'application/pdf', disposition: 'inline'
  end

  def partiel_resultat
    @utilisateur = session[:utilisateur]
  end

  def partiel_per
    render "candidat/partiel/per"
  end

  def partiel_permore
    render "candidat/partiel/permore"
  end

  def partiel_soc
    render "candidat/partiel/soc"
  end

  def partiel_socmore
    render "candidat/partiel/socmore"
  end

  def partiel_cog
    render "candidat/partiel/cog"
  end

  def partiel_cogmore
    render "candidat/partiel/cogmore"
  end

  def jeu_quizz
    render "jeu/quizz"
  end

  def jeu_tower
    render "jeu/tower"
  end

  def jeu_2048
    render "jeu/2048"
  end

  private

  def profil_score_params
    params.permit(:identity, :social, :logic, :pitch)
  end
end
