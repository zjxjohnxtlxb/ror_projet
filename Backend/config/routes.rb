Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  ActiveAdmin.routes(self)

  resource :utilisateur, only: [:create]

  post "/connexion", to: "utilisateur#login"
  get "/auto_connexion", to: "utilisateur#auto_login"

  get "/connectable", to: "utilisateur#connectable"
  post "/connectable", to: "utilisateur#connectable"
  patch "/connectable", to: "utilisateur#connectable"

  resources :candidats, controller: :candidat, only: [:update] do
    post "password", on: :member
    resources :parours, controller: :candidat, only: [:create, :destroy]
  end

  get "/compte", to: "candidat#compte"
  patch "/candidats/:candidat_id/parcours/:id", to: "candidat#compte_parcour"

  patch "/candidats/:candidat_id/profil_score", to: "candidat#update_profil_score"
  get "/candidats/:candidat_id/profil_score", to: "candidat#profil_score"

  get "/candidats", to: "recruteur#candidats"
  post "/connexion_recruteur", to: "recruteur#login"
  get "/auto_connexion_recruteur", to: "recruteur#auto_login"
  
  get "/equipes/:id", to: "recruteur#equipes"
  delete "/equipes/:id/:equipe_id/:candidat_id", to: "recruteur#destroy"
  post "/equipes", to: "recruteur#create"
  post "/equipe", to: "recruteur#create_equipe"
  patch "/equipe/:id", to: "recruteur#update_equipe"
  delete "/equipe/:id", to:  "recruteur#destroy_equipe"
end
