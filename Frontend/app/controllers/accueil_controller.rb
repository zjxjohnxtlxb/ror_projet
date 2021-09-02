class AccueilController < ApplicationController
  add_flash_types :success, :danger, :info

  def index
  end

  def connectable
      res = get "connectable"
      if res["status"] != "error"
        flash[:info] = "Nous travaillons sur cette partie"
      else
        flash[:danger] = "Erreur de connexion au serveur"
      end
      redirect_to action: "index"
  end

  def inscript
    if request.post?
      res = post "utilisateur", params["utilisateur"]
      if res["status"] != "error"
        flash[:success] = "Merci de nous rejoindre"
      else
        flash[:danger] = "Erreur de connexion au serveur"
      end
      redirect_to action: "index"
    end
  end
end
