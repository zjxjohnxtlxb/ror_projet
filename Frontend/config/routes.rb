Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope controller: :accueil do
    get "/" => :index
    get "/connectable" => :connectable
    get "/inscript" => :inscript
    post "/inscript" => :inscript
  end
  
  scope controller: :candidat do
    get "/candidat" => :index
    get "/candidat/connexion" => :connexion
    post "/candidat/connexion" => :connexion
    get "/candidat/deconnextion" => :deconnextion
    
    get "/candidat/partiel/home" => :partiel_home
    get "/candidat/partiel/" => :partiel_home
    get "/candidat/partiel/compte" => :partiel_compte
    post "/candidat/partiel/compte" => :compte_post
    get "/candidat/partiel/cv" => :partiel_cv
    get "/candidat/partiel/profil" => :partiel_profil
    get "/candidat/partiel/resultat" => :partiel_resultat
    
    get "/candidat/partiel/per" => :partiel_per
    get "/candidat/partiel/permore" => :partiel_permore
    get "/candidat/partiel/soc" => :partiel_soc
    get "/candidat/partiel/socmore" => :partiel_socmore
    get "/candidat/partiel/cog" => :partiel_cog
    get "/candidat/partiel/cogmore" => :partiel_cogmore

    get "/jeu/quizz" => :jeu_quizz
    get "/jeu/tower" => :jeu_tower
    get "/jeu/2048" => :jeu_2048
    get "/jeu/air_guitar" => :jeu_air_guitar
  end

  scope controller: :laboratoire do
    get "/laboratoire" => :index
  end
  
  scope controller: :recruteur do
    get "/equipe_manager" => :equipe_manager
    post "/equipe_manager" => :equipe_manager
    delete "/delete_equipe/:id" => :delete_equipe
    get "/recruteur/login" => :login
    post "/recruteur/login" => :login
  end
end
