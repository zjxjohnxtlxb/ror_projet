# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_09_152547) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categorie_soft_skills", force: :cascade do |t|
    t.string "nomCategorie"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "equipe_soft_skills", force: :cascade do |t|
    t.string "nomEquipe"
    t.integer "niveauImportance", default: 0
    t.integer "soft_skill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["soft_skill_id"], name: "index_equipe_soft_skills_on_soft_skill_id"
  end

  create_table "equipes", force: :cascade do |t|
    t.integer "recruteur_id", null: false
    t.integer "candidat_id", null: false
    t.integer "equipe_soft_skill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidat_id"], name: "index_equipes_on_candidat_id"
    t.index ["equipe_soft_skill_id"], name: "index_equipes_on_equipe_soft_skill_id"
    t.index ["recruteur_id", "candidat_id", "equipe_soft_skill_id"], name: "equipe_index", unique: true
    t.index ["recruteur_id"], name: "index_equipes_on_recruteur_id"
  end

  create_table "jeus", force: :cascade do |t|
    t.string "nomJeu"
    t.string "lienJeu"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parcours", force: :cascade do |t|
    t.string "metier"
    t.string "secteur"
    t.string "experience"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "utilisateur_id", null: false
    t.index ["utilisateur_id"], name: "index_parcours_on_utilisateur_id"
  end

  create_table "profil_scores", force: :cascade do |t|
    t.string "identity"
    t.string "social"
    t.string "logic"
    t.string "pitch"
    t.integer "utilisateur_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["utilisateur_id"], name: "index_profil_scores_on_utilisateur_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "resultat"
    t.date "dateScores"
    t.integer "utilisateur_id", null: false
    t.integer "soft_skill_jeu_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["soft_skill_jeu_id"], name: "index_scores_on_soft_skill_jeu_id"
    t.index ["utilisateur_id"], name: "index_scores_on_utilisateur_id"
  end

  create_table "soft_skill_jeus", force: :cascade do |t|
    t.integer "soft_skill_id", null: false
    t.integer "jeu_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jeu_id"], name: "index_soft_skill_jeus_on_jeu_id"
    t.index ["soft_skill_id", "jeu_id"], name: "soft_skill_jeu_index", unique: true
    t.index ["soft_skill_id"], name: "index_soft_skill_jeus_on_soft_skill_id"
  end

  create_table "soft_skills", force: :cascade do |t|
    t.string "nomSoftSkill"
    t.integer "categorie_soft_skill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["categorie_soft_skill_id"], name: "index_soft_skills_on_categorie_soft_skill_id"
  end

  create_table "utilisateurs", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "email"
    t.date "dateDeNaissance"
    t.string "telephone"
    t.integer "roleNo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "niveauExperience"
    t.string "passion1"
    t.string "passion2"
    t.string "passion3"
    t.string "linkFacebook"
    t.string "linkTwitter"
    t.string "linkLinkedin"
    t.string "linkViadeo"
    t.string "password_digest"
    t.index ["email"], name: "index_utilisateurs_on_email", unique: true
  end

  add_foreign_key "equipe_soft_skills", "soft_skills"
  add_foreign_key "equipes", "equipe_soft_skills"
  add_foreign_key "equipes", "utilisateurs", column: "candidat_id"
  add_foreign_key "equipes", "utilisateurs", column: "recruteur_id"
  add_foreign_key "parcours", "utilisateurs"
  add_foreign_key "profil_scores", "utilisateurs"
  add_foreign_key "scores", "soft_skill_jeus"
  add_foreign_key "scores", "utilisateurs"
  add_foreign_key "soft_skill_jeus", "jeus"
  add_foreign_key "soft_skill_jeus", "soft_skills"
  add_foreign_key "soft_skills", "categorie_soft_skills"
end
